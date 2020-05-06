# Add contents to certain file
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
    REGEX=":a;N;\$!ba;s/.*\(${CFG_CONTENTS//\//\\/}\).*/\1/p"
    local FD=$(cat $TARGET_FILE | sed -n "$REGEX" | tr -d "\0" )

    if [ -z "$FD" ]; then
        echo -e "${CFG_CONTENTS}\n" >> "$TARGET_FILE"
    fi
}

