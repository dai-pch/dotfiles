#!/usr/bin/env bash

BREW_CMD="$(which brew)"

if [ -z "$BREW_CMD" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

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

