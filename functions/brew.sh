# get directory path of brew binary
get_brew_dir() {
    local BREW_DIR=""
    local ROOT1="$HOME/.linuxbrew/bin"
    local ROOT2="/home/linuxbrew/.linuxbrew/bin"
    local ROOT3="/usr/local/bin"
    # if file not exists, create file first
    if [[ -x "$ROOT1/brew" ]]; then
        BREW_DIR=$ROOT1
    elif [[ -x "$ROOT2/brew" ]]; then
        BREW_DIR=$ROOT2
    elif [[ -x "$ROOT3/brew" ]]; then
        BREW_DIR=$ROOT3
    else
        BREW_DIR=
    fi
    echo $BREW_DIR
}

# Run Homebrew/Linuxbrew main program
brew() {
    local LOCAL_PATH="$HOME/.local/bin"
    local BREW_PATH="$(get_brew_dir)"
    # if file not exists, create file first
    if [ -z "$BREW_PATH" ]; then
        echo Error: brew not found.
        return 1
    fi

    PATH="$BREW_PATH:$PATH" $BREW_PATH/brew "$@"
    local RET=$?
    if [ $RET -ne 0 ]; then
        echo Run brew error.
        return $RET
    fi
    local FORMULARS=${@:2}
    # on install
    for formular in $FORMULARS; do
        if [[ ! $formular == "-"* ]]; then
            if [[ "install" == "$1" ]]; then
                if [ ! -x "$LOCAL_PATH/$formular" ]; then
                    ln -s "$BREW_PATH/$formular" "$LOCAL_PATH/$formular"
                    [ $? -eq 0 ] && echo Symlink created for $formular.
                fi
            elif [[ "uninstall" == "$1" ]]; then
                if [ -L "$LOCAL_PATH/$formular" ]; then
                    unlink "$LOCAL_PATH/$formular"
                    [ $? -eq 0 ] && echo Remove $formular.
                fi
            fi
        fi
    done
}

