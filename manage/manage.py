#!/bin/env python3

import sys
from module_sys import *
from model import Suite

def install(args: list[str]):
    msys = ModuleSystem(CliLogger())
    msys.scan_modules()
    suite = Suite({ModuleId(m): RunConfig(required=True) for m in args})
    msys.run_suite(suite)
    return

def all():
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
manage install [modules] -- install specified modules
manage all -- list all available modules
"""

def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else None
    args = sys.argv[2:]
    match cmd:
        case "install":
            install(args)
        case "all":
            all()
        case _:
            print(help)
    return

if __name__ == "__main__":
    main()