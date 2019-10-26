# input $1: some path
# return the absolute path of input
abspath() {
    local SOURCE="$1"
    if [ -d "$SOURCE" ]; then
        while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
            SOURCE="$( cd -P "$SOURCE" && pwd )"
        done
        echo $SOURCE
    else
        local DIR=
        while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
            DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
            SOURCE="$(readlink "$SOURCE")"
            [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
        done
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(basename "$SOURCE")"
        echo $DIR/$SOURCE
    fi
}

