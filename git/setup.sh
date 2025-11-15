#!/usr/bin/env bash
source "$(dirname "$BASH_SOURCE[0]")/../common.sh"

# depends on add_to_file function
source $DOTFILES_ROOT/functions/add_to_file.sh

GIT_CMD="$(which git)"

if [ ! -z "$GIT_CMD" ]; then
    git config --global alias.st status 
    git config --global alias.co checkout 
    git config --global alias.ci commit 
    git config --global alias.br branch 
    git config --global branch.sort -committerdate 

#     if [ -z "$(git config --get user.email)" ]; then
#         git config --global user.email="dpc_work@163.com"
#     fi
#     if [ -z "$(git config --get user.name)" ]; then
#         git config --global user.name="Dai, Pengcheng"
#     fi
fi

# auto complete
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
chmod +x ~/.git-completion.bash
add_to_shrc 'test -f ~/.git-completion.bash && . $_'
