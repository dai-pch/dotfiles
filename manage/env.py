import subprocess
from model import Logger
from dataclasses import dataclass
import os
from os import path
from typing import Optional, Any

@dataclass
class Env:
    logger: Logger
    dotfiles_root: str
    module_path: str
    module_name: str
    # script_dir: str

    def exec_cmd(self, cmd: str | list[str]) -> bool:
        if isinstance(cmd, str):
            cmd = cmd.split(' ')
        self.logger.info(f"Runing command: {' '.join(cmd)}.")
        res = subprocess.run(cmd, stdout=subprocess.PIPE)
        out = res.stdout.strip()
        if len(out) > 0:
            [self.logger.info(line) for line in str(res.stdout).splitlines()]
        succ = res.returncode == 0
        return succ

    def exec_bash(self, script_file: str) -> bool:
        self.logger.info(f"Runing bash script {script_file}.")
        script_path = path.join(self.module_path, script_file)
        res = subprocess.run(["bash", script_path], stdout=subprocess.PIPE)
        out = res.stdout.strip()
        if len(out) > 0:
            [self.logger.info(line) for line in str(res.stdout).splitlines()]
        succ = res.returncode == 0
        return succ

    def cmd_exists(self, cmd: str) -> bool:
        res = subprocess.run(["which", cmd], capture_output=True)
        cmd_path = res.stdout.strip()
        if len(res.stderr) > 0:
            [self.logger.error(line) for line in str(res.stderr).splitlines()]
        succ = res.returncode == 0 and len(cmd_path) > 0
        return succ

    def file_exists(self, path: str) -> bool:
        return os.path.exists(path)
        
    def add_to_file(
            self, path: str, 
            contents: str | list[str], 
            tag: Optional[str] = None,
        ) -> bool:
        if len(contents) == 0:
            return True
        if isinstance(contents, str):
            contents = [contents]
        if tag is None:
            tag = self.module_name
        self.logger.info(f"Modifing file {path}")
        head = '##### Added by dotfiles {} #####\n'.format(tag)
        end = '##### Ending {} #####\n'.format(tag)
        origin_lines = []
        try:
            with open(path, mode="r") as file: 
                origin_lines = file.readlines()
        except FileNotFoundError:
            pass
        lines: list[str] = []
        headline_idx = _index_of(origin_lines, head)
        endline_idx = _index_of(origin_lines, end)
        block_exists = headline_idx is not None and endline_idx is not None
        if block_exists:
            lines.extend(origin_lines[:headline_idx])
        else:
            lines.extend(origin_lines)
            lines.append('')
        lines.append(head)
        lines.extend([wrap_newline(c) for c in contents])
        lines.append(end)
        if endline_idx is not None and endline_idx < len(origin_lines):
            lines.extend(origin_lines[endline_idx+1:])
        else:
            lines.append('\n')
        with open(path, 'w') as file:
            file.writelines(lines)
        return True

def _index_of(l: list[Any], c: Any) -> Optional[int]:
    try:
        return l.index(c)
    except ValueError:
        return None

def wrap_newline(s: str) -> str:
    if s.endswith('\n'):
        return s
    return s+'\n'