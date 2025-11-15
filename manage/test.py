from module_sys import *
from env import Env

def unwrap[T](opt: Optional[T]) -> T:
    if opt is None:
        raise Exception("None value.")
    return opt

def main():
    # test_find_modules()
    # test_calc_targets()
    test_run()
    # test_exec()

def test_find_modules():
    sys = ModuleSystem(CliLogger())
    sys.scan_modules()
    sys.print()

def test_calc_targets():
    sys = ModuleSystem(CliLogger())
    sys.scan_modules()
    config = Suite({ModuleId("bytedance.goproxy"): RunConfig(required=True)})
    targets = sys.calc_run_targets(config)
    print(targets)
    assert(targets == {
        ModuleId('go'), 
        ModuleId('bytedance.goproxy'),
    })

def test_run():
    sys = ModuleSystem(CliLogger())
    sys.scan_modules()
    suite = Suite({
        # ModuleId("git_config"): RunConfig(required=True),
        # ModuleId("bytedance.git_config"): RunConfig(required=True),
        # ModuleId("saferm"): RunConfig(required=True),
        ModuleId("go"): RunConfig(required=True),
        })
    targets = sys.calc_run_targets(suite)
    print(targets)
    sys.run_suite(suite)

def test_exec():
    logger = CliLogger()
    context: dict[str, Any] = {
        "logger": logger,
        "home": "aa",
    }
    tools = Env(
        logger=logger,
        dotfiles_root='..',
        module_path='.',
        module_name='test',
    )
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
