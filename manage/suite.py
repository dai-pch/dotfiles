from os import path
import json
from model import *

def get_suites() -> dict[str, Suite]:
    suite_file_path = path.join(path.dirname(__file__), 'suites.json')
    with open(suite_file_path, 'r') as suite_file:
        suite_data_list = json.load(suite_file)
    suites: dict[str, Suite] = {
        data["name"]: Suite(
            name = data["name"], 
            modules = { ModuleId(name): RunConfig(**cfg) for name, cfg in data.get("modules", {}).items()},
        ) for data in suite_data_list
    }
    return suites