#!/usr/bin/env bash

DOTFILES_ROOT="$(dirname "$0")"
 
cd $DOTFILES_ROOT && git pull && setup_all.sh

