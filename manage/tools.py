import subprocess
from model import Logger

class Env:
    def __init__(self, logger: Logger):
        self.logger = logger

    def exec_bash(self, cmd: str) -> bool:
        res = subprocess.run(["bash", cmd], capture_output=True)
        cmd_path = res.stdout.strip()
        self.logger.info(f"Runing bash script {cmd}.")
        if res.returncode != 0:
            if len(res.stderr) > 0:
                self.logger.error(str(res.stderr))
            succ = False
        elif len(cmd_path) > 0:
            succ = True
        else:
            succ = False
        return succ

    def cmd_exist(self, cmd: str) -> bool:
        res = subprocess.run(["which", cmd], capture_output=True)
        cmd_path = res.stdout.strip()
        # self.logger.info(f"Runing command which {cmd}.")
        if res.returncode != 0:
            if len(res.stderr) > 0:
                self.logger.warn(str(res.stderr))
            self.logger.warn(f"Command {cmd} not found.")
            succ = False
        elif len(cmd_path) > 0:
            succ = True
        else:
            succ = False
        return succ
