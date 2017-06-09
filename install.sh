#!/usr/bin/env bash

SCRIPT_HOME=`pwd`/$(dirname "$0")
LOG_MODULE=""

defaultColor="\033[0m"
redColor="\033[1;31m"
greenColor="\033[1;32m"
yellowColor="\033[1;33m"

#
# Logging functions.
#
log() {
    echo -e "[$yellowColor$LOG_MODULE$defaultColor] $1"
}

log_ins() {
    LOG_MODULE="$1"
    log "Installing $1 configuration..."
}

log_rm() {
    log "${redColor}Deleting existing file '$1'$defaultColor"
}

log_ln() {
    log "${greenColor}Symbolic link $1 created!$defaultColor"
}

log_cp() {
    log "${greenColor}Copying files to $1.$defaultColor"
}

log_ins_end() {
    log "Configuration done!\n"
    LOG_MODULE=""
}
#
# End logging functions.
#

#
# Install git config stuff
#
ins_git() {
    #echo "Installing git configuration..."
    log_ins "git"
    if [ -f $HOME/.gitconfig ]; then
        log_rm ".gitconfig"
        rm $HOME/.gitconfig
    fi
    ln -sf $SCRIPT_HOME/gitconfig .gitconfig
    log_ln ".gitconfig"
    log_ins_end
}

#
# Install zsh config
#
ins_zsh() {
    log_ins "zsh"
    if [ -f $HOME/.zshrc ]; then
        log_rm ".zshrc"
        rm $HOME/.zshrc
    fi
    ln -sf $SCRIPT_HOME/zshrc .zshrc
    log_ln ".zshrc"

    # oh-my-zsh
    if [ -d $HOME/.oh-my-zsh ]; then
        log_rm ".oh-my-zsh"
        rm -Rf $HOME/.oh-my-zsh
    fi
    ln -sf $SCRIPT_HOME/oh-my-zsh .oh-my-zsh
    log_ln ".oh-my-zsh"

    # oh-my-zsh-custom
    cp -r $SCRIPT_HOME/oh-my-zsh-custom/* .oh-my-zsh/custom
    log_cp ".oh-my-zsh/custom"

    log_ins_end
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
ins_zsh

