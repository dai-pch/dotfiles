#!/usr/bin/env bash

install_from_source() {
    local TMPDIR="/tmp/$1"
    local URL=$2 # "https://ftp.gnu.org/pub/gnu/global/global-6.6.3.tar.gz"
    local FLAGS=$3
    local FILENAME="$(basename "$URL")"
    # echo $FILENAME
    mkdir -p "$TMPDIR" && cd "$TMPDIR"
    if [ ! -f "$FILENAME" ]; then
        wget $URL
    fi
    tar xf $FILENAME
    local EXTRACTDIR="$(find . -mindepth 1 -maxdepth 1 -type d)"
    cd "${EXTRACTDIR[0]}"
    ./configure --prefix="$HOME/.local" $FLAGS && make -j$(nproc) && make install
}

