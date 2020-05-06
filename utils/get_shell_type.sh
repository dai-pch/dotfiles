#!/usr/bin/env bash

get_shell_type() {
    local shell_path

    shell_path=$SHELL
    if [ -n $($shell_path -c "echo \$ZSH_VERSION") ]; then
        echo "zsh"
    elif [ -n $($shell_path -c "echo \$BASH_VERSION") ]; then
        echo "bash"
    else
        echo "others"
    fi
}

