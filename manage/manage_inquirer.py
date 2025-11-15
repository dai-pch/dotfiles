import inquirer
from module_sys import *

def main():
    sys = ModuleSystem(CliLogger())
    sys.scan_modules()
    modules = sys.get_all_modules()
    installed = sys.get_installed_modules()
    questions = [
        inquirer.Checkbox(
            'select_modules', 
            message='Select modules to install.',
            choices=modules,
            locked=installed,
        )
    ]
    answers = inquirer.prompt(questions)
    pass

if __name__ == "__main__":
    main()