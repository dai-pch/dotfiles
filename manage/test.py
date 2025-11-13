from module_sys import *
from tools import Env

def main():
    # test_find_modules()
    # test_calc_targets()
    test_run()
    # test_exec()

def test_find_modules():
    project_root = ".."
    sys = ModuleSystem(CliLogger())
    sys.scan_modules(project_root)
    sys.print()

def test_calc_targets():
    project_root = ".."
    sys = ModuleSystem(CliLogger())
    sys.scan_modules(project_root)
    config = Suite({ModuleId("bytedance.goproxy"): RunConfig(required=False)})
    targets = sys.calc_run_targets(config)
    assert(targets == set())

def test_run():
    project_root = ".."
    sys = ModuleSystem(CliLogger())
    sys.scan_modules(project_root)
    suite = Suite({ModuleId("go"): RunConfig(required=True)})
    sys.run_suite(suite)

def test_exec():
    logger = CliLogger()
    context: dict[str, Any] = {
        "logger": logger,
        "home": "aa",
    }
    tools = Env(logger=logger)
    loc: dict[str, Any] = {
        "tools": tools,
    }
    # probe
    # check
    check_expr = "tools.cmd_exist('wget')"
    # check_expr = "print(cmd_exist)"
    check_pass = eval(check_expr, globals=context, locals=loc)
    print(check_pass)
    # print(env)
    print(loc)

if __name__ == "__main__":
    main()
