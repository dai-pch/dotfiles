
DOTFILES_ROOT="$HOME/.local/dotfiles"
INIT_FILE="init.sh"
DOTFILES_URL="https://github.com/dai-pch/dotfiles.git"
# TARGET_FILE="./test"
TARGET_FILE="$HOME/.bashrc"

if [ -f "$DOTFILES_ROOT" ]; then
    echo "File $DOTFILES_ROOT already exits."
    exit
fi

# if already have dotfiles, just update
if [ -d "$DOTFILES_ROOT" ]; then
    $DOTFILES_ROOT/update.sh
    exit
fi

mkdir -p $DOTFILES_ROOT
git clone $DOTFILES_URL $DOTFILES_ROOT
setup_all.sh

