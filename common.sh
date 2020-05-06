if [ ! -z $BASH_VERSION ]; then
    DOTFILES_ROOT="$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd -P)"
elif [ ! -z $ZSH_VERSION ]; then
    DOTFILES_ROOT="$(cd "$(dirname "${(%):-%N}")" && pwd -P)"
fi

