#!/usr/bin/env bash

get_shell_type() {
    local shell_path

    shell_path=$SHELL
    if [ ! -z $($shell_path -c "echo \$ZSH_VERSION") ]; then
        echo "zsh"
    elif [ ! -z $($shell_path -c "echo \$BASH_VERSION") ]; then
        echo "bash"
    else
        echo "others"
    fi
}

