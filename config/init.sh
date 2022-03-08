# loaded only once
if [ -z "$_INIT_SH_LOADED" ]; then
    _INIT_SH_LOADED=1
else
    return
fi

# exit if not in interactive mode
case "$-" in
    *i*) ;;
    *) return;;
esac

# get dotfiles root path
if [ ! -z $BASH_VERSION ]; then
    source "$(dirname "$BASH_SOURCE[0]")/../common.sh"
elif [ ! -z $ZSH_VERSION ]; then
    source "$(dirname "${(%):-%N}")/../common.sh"
fi

# source all functions
FUNCDIR="$DOTFILES_ROOT/functions"
FUNCTIONS="$(find "$FUNCDIR" -maxdepth 1 -name "*.sh")"
if [ ! -z $ZSH_VERSION ]; then
    IFS=$'\n' FUNCTIONS=($(echo $FUNCTIONS))
fi
for FUNC_FILE in $FUNCTIONS
do
    source "$FUNC_FILE"
done

# set some env var
PATH=$HOME/.local/bin:$PATH
LIBRARY_PATH=$HOME/.local/lib:$LIBRARY_PATH
LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
C_INCLUDE_PATH=$HOME/.local/include:$C_INCLUDE_PATH
CPLUS_INCLUDE_PATH=$HOME/.local/include:$CPLUS_INCLUDE_PATH
if [ -d "$HOME/.local/include" ]; then
    for dir in $(find "$HOME/.local/include" -mindepth 1 -maxdepth 1 -type d)
    do
        C_INCLUDE_PATH="$dir:$C_INCLUDE_PATH"
        CPLUS_INCLUDE_PATH="$dir:$CPLUS_INCLUDE_PATH"
    done
fi

export LIBRARY_PATH="$(trim $LIBRARY_PATH ":")"
export LD_LIBRARY_PATH="$(trim $LD_LIBRARY_PATH ":")"
export C_INCLUDE_PATH="$(trim $C_INCLUDE_PATH ":")"
export CPLUS_INCLUDE_PATH="$(trim $CPLUS_INCLUDE_PATH ":")"

# source all config file
CONFIGDIR="$DOTFILES_ROOT/config"
CONFIGS="$(find $CONFIGDIR -maxdepth 1 -name "*.sh" |grep -ve "init.sh\|setup.sh")"
CONFIGS="$(echo $CONFIGS | tr " " "\n" | sort -n -t "-")"
if [ ! -z $ZSH_VERSION ]; then
    CONFIGS=("${(f)CONFIGS}")
fi

for CONFIG_FILE in $CONFIGS
do
    source $CONFIG_FILE
done

# remove redundant items in PATH
if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}      
        case $PATH: in
            *:"$x":*) ;;         
            *) PATH=$PATH:$x;;  
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
fi
# remove end :
PATH="$(trim "$PATH" ":")"

export PATH

