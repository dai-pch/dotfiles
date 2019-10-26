# loaded only once
if [ -z "$_INIT_SH_LOADED" ]; then
    _INIT_SH_LOADED=1
else
    return
fi

# exit if not in interactive mode
case "$-" in
    *i*) ;;
    *) return
esac

# get dotfiles root path
source "$(dirname "$BASH_SOURCE[0]")/../common.sh"

# source all functions
FUNCDIR="$DOTFILES_ROOT/functions"
FUNCTIONS="$(ls "$FUNCDIR")"
for FUNC_FILE in "$FUNCTIONS"
do
    source "$FUNCDIR/$FUNC_FILE"
done

# source all config file
CONFIGDIR="$DOTFILES_ROOT/config"
CONFIGS="$(find $CONFIGDIR -name "*.sh" |grep -ve "init.sh\|setup.sh")"
for CONFIG_FILE in $CONFIGS
do
    source "$CONFIGDIR/$CONFIG_FILE"
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

export PATH

