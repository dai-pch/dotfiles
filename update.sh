#!/usr/bin/env bash

source "$(dirname "$0")/common.sh"
 
cd $DOTFILES_ROOT && git pull && ./setup_all.sh

