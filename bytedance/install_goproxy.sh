CLI_FILE_PATH="$HOME/.local/bin/goproxy_setup_cli"

if [ ! -f "$CLI_FILE_PATH" ]; then
  mkdir -p ~/.local/bin 
  wget https://luban-source.byted.org/repository/asset/test/goproxy_setup_cli/goproxy_setup_cli_linux_amd64 -O "$CLI_FILE_PATH" 
  chmod +x  "$CLI_FILE_PATH"
fi

