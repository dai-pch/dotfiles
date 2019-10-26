# input $1: some dir path
# return the absolute directory path of current workspace
get_absdir() {
    if [ -d "$1" ]; then
        echo "$(cd "$1" && pwd -P)"
    else
        echo "$(cd "$(dirname "$1")" && pwd -P)"
    fi
}

