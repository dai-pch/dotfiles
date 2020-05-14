# Run Homebrew/Linuxbrew main program
brew() {
    local BREW_PATH=""
    local ROOT1="$HOME/.linuxbrew/bin"
    local ROOT2="/home/linuxbrew/.linuxbrew/bin"
    local ROOT3="/usr/local/bin"
    # if file not exists, create file first
    if [[ -x "$ROOT1/brew" ]]; then
        BREW_PATH=$ROOT1
    elif [[ -x "$ROOT2/brew" ]]; then
        BREW_PATH=$ROOT2
    elif [[ -x "$ROOT3/brew" ]]; then
        BREW_PATH=$ROOT3
    else
        echo Error: brew not found.
        exit 1
    fi

    PATH="$BREW_PATH:$PATH" $BREW_PATH/brew "$@"
}

