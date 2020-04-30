#!/usr/bin/env bash

BREW_CMD="$(which brew)"

if [ -z "$BREW_CMD" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

