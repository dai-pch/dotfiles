#!/usr/bin/env bash

TARGET="$HOME/.local/bin/rm"
TMPDIR="/tmp/saferm"
if [ ! -e "$TARGET" ]; then
    rm -rf $TMPDIR
    mkdir -p $TMPDIR && cd $TMPDIR
    wget https://github.com/MilesCranmer/rip2/releases/download/v0.9.5/rip-Linux-x86_64-musl.tar.gz -O rip.tar.gz
    tar -xf rip.tar.gz
    cp ./rip $TARGET
fi

