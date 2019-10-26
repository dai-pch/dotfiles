#!/usr/bin/env bash
DOTFILES_ROOT=$(cd "$(dirname "$0")" && pwd)

set -e

cd "$DOTFILES_ROOT"
find . -name setup.sh | while read installer; do $installer; done

