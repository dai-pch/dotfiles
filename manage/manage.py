#!/bin/env python

import sys
from functools import reduce
from module_sys import *
from suite import *
from model import Suite

def install_module(args: list[str]):
    msys = ModuleSystem(CliLogger())
    msys.scan_modules()
    all_modules = msys.get_all_modules()
    modules = args
    for m in modules:
        if m not in all_modules:
            print(f'[Error] module "{m}" not available.')
            exit(1)
    suite = Suite({ModuleId(m): RunConfig(required=True) for m in modules})
    msys.run_suite(suite)
    return

def install_suites(args: list[str]):
    msys = ModuleSystem(CliLogger())
    msys.scan_modules()
    all_suites = get_suites()
    for m in args:
        if m not in all_suites:
            print(f'[Error] suite "{m}" not available.')
            exit(1)
    suites = [all_suites[suite] for suite in args]
    suite = reduce(merge_suite, suites)
    msys.run_suite(suite)
    return

def all():
    all_suites = get_suites()
    print(f"All suites:")
    for name in all_suites.keys():
        print(name)
    msys = ModuleSystem(CliLogger())
    msys.scan_modules()
    modules = msys.get_all_modules()
    modules.sort()
    installed = set(msys.get_installed_modules())
    print(f"All modules:")
    for m in modules:
        line = m
        if m in installed:
            line = line + ' (installed)'
        print(line)
    return

help = """usage: 
manage install_module [modules ...] -- install specified modules
manage install_suite [suites ...] -- install specified suites
manage all -- list all available modules
"""

def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else None
    args = sys.argv[2:]
    match cmd:
        case "install_module":
            install_module(args)
        case "install_suite":
            install_suites(args)
        case "all":
            all()
        case _:
            print(help)
    return

if __name__ == "__main__":
    main()