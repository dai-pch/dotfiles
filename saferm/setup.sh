#!/usr/bin/env bash

TARGET="$HOME/.local/bin/rm"
TMPDIR="/tmp/saferm"
if [ ! -e "$TARGET" ]; then
    mkdir -p $TMPDIR && cd $TMPDIR
    if [ ! -e "shell-safe-rm" ]; then
        git clone https://github.com/kaelzhang/shell-safe-rm
    fi
    cd shell-safe-rm
    git checkout 1.0.7 > /dev/null
    cp ./bin/rm.sh $TARGET
fi

