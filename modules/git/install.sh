#!/usr/bin/env bash

#echo "Installing git configuration..."
log_ins "git"
if [ -f $HOME/.gitconfig ]; then
    log_rm ".gitconfig"
    rm $HOME/.gitconfig
fi
ln -sf $SCRIPT_HOME/modules/git/gitconfig .gitconfig
log_ln ".gitconfig"
log_ins_end
