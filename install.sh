#!/usr/bin/env bash

SCRIPT_HOME=`pwd`/$(dirname "$0")

#
# Install git config stuff
#
ins_git() {
    echo "Installing git configuration..."
    if [ -f $HOME/.gitconfig ]; then
        echo "Git configuration exists! Excluding existing .gitconfig"
        rm $HOME/.gitconfig
    fi
    ln -sf $SCRIPT_HOME/gitconfig .gitconfig
    echo -e "Git configuration done!\n"
}

# Working from home :)
cd ~

echo "========================================================================"
echo "Installing dotfiles"
echo "Using parameters:"
echo "SCRIPT_HOME=$SCRIPT_HOME"
echo ""

# Do the installs...
ins_git

