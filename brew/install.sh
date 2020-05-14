#!/usr/bin/env bash
source "$(dirname "$BASH_SOURCE[0]")/../common.sh"

# depends on add_to_file function
source $DOTFILES_ROOT/functions/brew.sh
BREW_PATH="$(get_brew_dir)"

if [ -z "$BREW_PATH" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    # change source
    git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
    if [ "$(uname)" == "Darwin" ]; then
        git -C "$(brew --repo homebrew/core)" remote set-url origin \
            https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
        git -C "$(brew --repo homebrew/cask)" remote set-url origin \
            https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
        git -C "$(brew --repo homebrew/cask-fonts)" remote set-url origin \
            https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
        git -C "$(brew --repo homebrew/cask-drivers)" remote set-url origin \
            https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        git -C "$(brew --repo homebrew/core)" remote set-url origin \
            https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/linuxbrew-core.git
    else
        echo "Unsupported system."
    fi

fi

