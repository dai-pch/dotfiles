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
    local FD=$(grep -Pzoe "$CFG_CONTENTS" $TARGET_FILE | tr -d "\0" )

    if [ -z "$FD" ]; then
        echo -e "${CFG_CONTENTS}\n" >> "$TARGET_FILE"
    fi
}

