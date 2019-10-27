#!/usr/bin/env bash

URL="https://ftp.gnu.org/pub/gnu/global/global-6.6.3.tar.gz"
source "$(dirname $0)/../utils/install_from_source.sh"
if [ -z "$(which gtags-cscope)" ]; then
    install_from_source gtags $URL
fi

