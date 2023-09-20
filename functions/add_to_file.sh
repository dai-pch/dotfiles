source "$(dirname "$BASH_SOURCE[0]")/../common.sh"

# depends on add_to_file function
source $DOTFILES_ROOT/utils/get_shell_type.sh

add_to_file() {
    local CFG_CONTENTS=$2 # "##### Added by dotfiles bootstrap #####\nsource $DOTFILES_ROOT/$INIT_FILE"
    local TARGET_FILE=$1
    # if file not exists, create file first
    if [ -d "$TARGET_FILE" ]; then
        echo "Warnning: $TARGET_FILE is a directory. Skipped."
    fi
    if [ ! -f "$TARGET_FILE" ]; then
        touch "$TARGET_FILE" 
    fi

    # find out if contents already exists
    local REGEX="s/.*\\(${CFG_CONTENTS//\//\\/}\\).*/\\1/p"
    local FD=$(cat $TARGET_FILE | sed -n -e ":a" -e "N" -e '$!ba' -e "$REGEX" | tr -d "\0" )

    if [ -z "$FD" ]; then
        echo -e "${CFG_CONTENTS}\n" >> "$TARGET_FILE"
    fi
}

add_to_shrc() {
    local CONTENTS=$1
    case $(get_shell_type) in
        bash*)
            add_to_file "$HOME/.bashrc" "$CONTENTS"
            ;;
        zsh*)
            add_to_file "$HOME/.zshrc" "$CONTENTS"
            ;;
        *)
            echo "Unsupported shell type."
    esac
}

