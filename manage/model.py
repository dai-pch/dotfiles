from typing import NewType, Any, Optional
from dataclasses import dataclass, field
from abc import ABC, abstractmethod

# types
# 某个module相对于project root的相对路径
RelPath = NewType('RelPath', str)
ModuleId = NewType('ModuleId', str)
Expr = NewType('Expr', str)

# code
class Logger(ABC):
    @abstractmethod
    def info(self, msg: str):
        pass

    @abstractmethod
    def warn(self, msg: str):
        pass

    @abstractmethod
    def error(self, msg: str):
        pass

    @abstractmethod
    def fatal(self, msg: str):
        pass

@dataclass
class ModuleDef:
    name: ModuleId
    depends_on: list[ModuleId] = field(default_factory=list[ModuleId])
    probe: Optional[Expr] = None
    check: Optional[Expr] = None
    run: Optional[Expr] = None

@dataclass
class RunConfig:
    required: bool = True # 如果为true，则会安装所有依赖模块，否则仅在依赖完整的情况下执行
    options: dict[str, Any] = field(default_factory=dict[str, Any])

@dataclass
class Suite:
    run_set: dict[ModuleId, RunConfig]

    def get_module_ids(self, required: bool | None = None) -> set[ModuleId]:
        """获取模块名称列表：
           required 为None返回所有模块
           required 非None仅返回对应required字段与入参一致的模块
        """
        return {
            id for id, item in self.run_set.items() 
            if (required is None) or (item.required == required) 
        }

@dataclass
class RunEnv:
    # env
    home: str
    logger: Logger
    # state
    check_pass: bool = True
    run_success: bool = True
