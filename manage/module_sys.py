from typing import Self, Any, Optional, Tuple, Iterable
import json
import os
from os import path
from copy import copy
from model import *
from env import Env

# consts 
# EnvHome: Optional[str] = os.getenv("HOME")
ModuleDefFileName: str = "modules.json"
ModuleRecordFileName: str = ".dotfile_installed"

class Module:
    def __init__(self, module_def: ModuleDef, relative_path: RelativePath):
        # TODO: check
        if len(module_def.name) == 0:
            raise Exception("module has no name")
        if len(relative_path) == 0:
            relative_path = RelativePath(".")
        # module_def.depend_modules = list(set(module_def.depend_modules))
        self._module_def = module_def
        self.relative_path = relative_path 

    def get_name(self) -> ModuleId:
        return self._module_def.name
    
    def get_dependent_modules(self) -> set[ModuleId]:
        return set(self._module_def.depends_on)
    
    def get_check_expr(self) -> Optional[Expr | list[Expr]]:
        return self._module_def.check
    
    def get_probe_expr(self) -> Optional[Expr]:
        return self._module_def.probe
    
    def get_run_expr(self) -> Optional[Expr | list[Expr]]:
        return self._module_def.run
    
    @classmethod
    def parse_list_from_str(cls, module_def_str: str, relative_path: RelativePath) -> list[Self]:
        module_def_list: list[ModuleDef] = json.loads(
            module_def_str, 
            object_hook=lambda datas: [ModuleDef(**data) for data in datas],
        )
        # module_def = ModuleDef(module_def)
        return [cls(module_def, relative_path) for module_def in module_def_list] 

    @classmethod
    def parse_from_file(cls, file_path: str, relative_path: RelativePath) -> list[Self]:
        with open(file_path) as module_file:
            module_data_list: list[dict[Any, Any]] = json.load(module_file)
            module_def_list: list[ModuleDef] = [ModuleDef(**data) for data in module_data_list]
            return [cls(module_def, relative_path) for module_def in module_def_list] 

class ModuleSystem:
    def __init__(self, logger: Logger):
        self._all_modules = dict[ModuleId, Module]()
        self._dependencies = dict[ModuleId, set[ModuleId]]()
        self._logger = logger
        home_path: str | None = os.getenv("HOME")
        if home_path is None:
            raise Exception(f"Home directory not found.")
        self.home_path: str = home_path
        self.dotfiles_root: str = path.abspath(path.join(path.dirname(__file__), '..'))

    def scan_modules(self):
        for cur_path, _, filenames in os.walk(self.dotfiles_root):
            rel_path: RelativePath = RelativePath(path.relpath(cur_path, start=self.dotfiles_root))
            if ModuleDefFileName not in filenames:
                continue
            modules: list[Module] = Module.parse_from_file(
                path.join(cur_path, ModuleDefFileName), 
                rel_path,
            )
            self.add_modules(modules)
        # validate dependencies exists
        for id in self._all_modules.keys():
            for module_name in self.dependencies_of(id):
                if module_name not in self._all_modules:
                    raise Exception(f"Module {module_name} not found.")
        # sort and validate no cycle dependencies
        (self._sorted_modules, remain) = self._sort_modules(self._all_modules.keys())
        if len(remain) > 0:
            raise Exception(f"Fund cyclic dependenties between modules {remain}")
    
    def get_all_modules(self) -> list[ModuleId]:
        return list(self._all_modules.keys())

    def run_suite(self, suite: Suite):
        target_modules: set[ModuleId] = self.calc_run_targets(suite)
        if len(target_modules) == 0:
            self._logger.info("All modules already installed.")
            return
        target_module_queue: list[ModuleId] = [
            module for module in self._sorted_modules 
            if module in target_modules
        ]
        self._logger.info(f"These modules will be installed: {target_module_queue}.")
        for module in target_module_queue:
            self._logger.info("Installing module {}".format(module))
            cfg = suite.modules.get(module, RunConfig())
            succ = self.run_one(module, cfg)
            if not succ and cfg.required:
                return

    def run_one(self, module_name: ModuleId, cfg: RunConfig) -> bool:
        options: dict[str, Any] = cfg.options
        module: Module = self._all_modules[module_name]
        module_path = path.join(self.dotfiles_root, module.relative_path)
        # construct env
        env = Env(
            self._logger,
            self.dotfiles_root,
            module_path,
            module_name,
        )
        context: dict[str, Any] = {
            "logger": self._logger,
            "home": self.home_path,
            "env": env,
            "dotfiles_root": self.dotfiles_root,
            "module_path": module_path,
            **options
        }
        # probe
        probe_expr = module.get_probe_expr()
        if exec_expr(probe_expr, glb=context):
            self._logger.info("Module {} already satisfied.".format(module_name))
            self.record_installed(module_name)
            return True
        # check
        check_expr = module.get_check_expr()
        if not exec_expr(check_expr, glb=context):
            if cfg.required:
                self._logger.fatal(f"Module {module_name} check failed.")
            else:
                self._logger.warn(f"Module {module_name} check failed, skipped.")
            return False
        # mkdir temp dir
        current_dir = os.getcwd()
        workdir = path.join('/tmp/dotfiles', module_name)
        os.makedirs(workdir, exist_ok=True)
        os.chdir(workdir)
        # run
        run_success = False
        run_expr = module.get_run_expr()
        run_success = exec_expr(run_expr, glb=context)
        # record
        if not run_success:
            msg = f"Module {module_name} install failed."
            if cfg.required:
                self._logger.fatal(msg)
            else:
                self._logger.warn(msg)
        else:
            self.record_installed(module_name)
        os.chdir(current_dir)
        return run_success
            
    def record_installed(self, module_name: ModuleId):
        record_file_path: str = path.join(self.home_path, ModuleRecordFileName)
        try:
            with open(record_file_path, mode="r+") as record_file: 
                records: set[str] = {r.strip() for r in record_file.readlines()}
        except FileNotFoundError:
            records = set[str]()
        if module_name in records:
            return
        with open(record_file_path, mode="a") as record_file: 
            record_file.write(module_name)
            record_file.write('\n')

    def calc_run_targets(self, config: Suite) -> set[ModuleId]:
        modules: set[ModuleId] = config.get_module_ids(True)
        modules = self._extend_module_with_depencency(modules)
        installed_modules: set[ModuleId] = self.get_installed_modules()
        weak_modules: set[ModuleId] = config.get_module_ids(False)
        allowed_weak_modules = self._remove_unsatisfied_module(
            weak_modules, modules.union(installed_modules))
        target_modules: set[ModuleId] = modules.union(allowed_weak_modules)
        target_modules.difference_update(installed_modules)
        return target_modules
            
    def _sort_modules(self, modules: Iterable[ModuleId]) -> Tuple[list[ModuleId], set[ModuleId]]:
        in_map: dict[ModuleId, set[ModuleId]] = dict.fromkeys(modules, set[ModuleId]())
        out_degree: dict[ModuleId, int] = dict.fromkeys(modules, 0)
        for name in modules:
            deps = self.dependencies_of(name)
            deps.intersection_update(modules)
            out_degree[name] = len(deps)
            for dep in deps:
                if dep in in_map:
                    in_map[dep].add(name)
        queue: list[ModuleId] = [id for id, deg in out_degree.items() if deg == 0]
        remain: set[ModuleId] = {id for id, deg in out_degree.items() if deg != 0}
        result = list[ModuleId]()
        for name in queue:
            result.append(name)
            for affect_module in in_map[name]:
                out_degree[affect_module] -= 1
                if out_degree[affect_module] == 0:
                    queue.append(affect_module)
                    remain.remove(affect_module)
        return result, remain

    def add_modules(self, modules: list[Module]):
        for module in modules:
            name = module.get_name()
            if name in self._all_modules:
                raise Exception(f"Module {name} duplicated.")
            self._all_modules[name] = module
            self._dependencies[name] = module.get_dependent_modules()

    def print(self):
        print(json.dumps(self._all_modules, default=vars, indent=2))
        print(self._sorted_modules)

    def dependencies_of(self, module_name: ModuleId) -> set[ModuleId]:
        match self._dependencies.get(module_name):
            case None:
                raise Exception(f"Module {module_name} not found.")
            case deps:
                return deps

    def get_installed_modules(self) -> set[ModuleId]:
        record_file_path: str = path.join(self.home_path, ModuleRecordFileName)
        try:
            with open(record_file_path) as record_file: 
                return {
                    ModuleId(line.strip()) 
                    for line in record_file.readlines() 
                    if len(line.strip()) > 0
                }
        except FileNotFoundError:
            return set[ModuleId]()

    def _extend_module_with_depencency(self, modules: set[ModuleId]) -> set[ModuleId]:
        module_queue = list(modules)
        for module_name in module_queue:
            deps: set[ModuleId] = self.dependencies_of(module_name)
            modules.update(deps)
            module_queue.extend([
                dep for dep in deps 
                if dep not in module_queue
            ])
        return set(module_queue)

    def _remove_unsatisfied_module(
            self, candidate_modules: set[ModuleId], 
            base_modules: set[ModuleId],
    ) -> set[ModuleId]:
        """ 返回值(allowed_modules, denied_modules) """
        base_modules = copy(base_modules)
        candidates_with_order: list[ModuleId] = [
            module for module in self._sorted_modules 
            if module in candidate_modules
        ]
        allow_modules = set[ModuleId]()
        for name in candidates_with_order:
            deps = self.dependencies_of(name)
            if deps.issubset(base_modules):
                base_modules.add(name)
                allow_modules.add(name)
            else:
                self._logger.warn(
                    f"Module {name} will be skipped due to dependencies {deps.difference(base_modules)} not installed.")
        return allow_modules

class BlackHoleLogger(Logger):
    def info(self, msg: str):
        pass

    def warn(self, msg: str):
        pass

    def error(self, msg: str):
        pass

    def fatal(self, msg: str):
        pass

class CliLogger(Logger):
    def info(self, msg: str):
        print("[Info] "+msg)

    def warn(self, msg: str):
        print("[Warn] "+msg)

    def error(self, msg: str):
        print("[Error] "+msg)

    def fatal(self, msg: str):
        print("[Fatal] "+msg)

def exec_expr(
        expr: Optional[Expr | list[Expr]], 
        glb: dict[str, Any], 
        loc: Optional[dict[str, Any]] = None,
) -> Any:
    if expr is None:
        return True
    if isinstance(expr, list):
        for e in expr:
            if not exec_expr(e, glb, loc):
                return False
        return True
    return eval(expr, glb, loc)
