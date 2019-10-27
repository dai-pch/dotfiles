#!/usr/bin/env bash

URL="https://ftp.gnu.org/gnu/ncurses/ncurses-6.1.tar.gz"
PREFIX="$HOME/.local"
source "$(dirname $0)/../utils/install_from_source.sh"
if [ ! -e $PREFIX/include/ncurses ]; then
    install_from_source ncurses $URL "--with-shared"
fi
if [ ! -f $PREFIX/lib/libcurses.a ]; then
    ln -s libncurses.a libcurses.a
fi

