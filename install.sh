#!/usr/bin/env bash

SCRIPT_HOME=`pwd`/$(dirname "$0")
LOG_MODULE=""

# make a tmp dir for the script
TMP_SCRIPT_DIR=${SCRIPT_HOME}/tmp
mkdir -p ${TMP_SCRIPT_DIR}

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

log_download() {
    log "${greenColor}Downloading $1.${defaultColor}"
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
# Install zsh config
#
ins_zsh() {
    log_ins "zsh"
    if [ -f $HOME/.zshrc ]; then
        log_rm ".zshrc"
        rm $HOME/.zshrc
    fi

    # oh-my-zsh
    if [ -d $HOME/.oh-my-zsh ]; then
        log_rm ".oh-my-zsh"
        rm -Rf $HOME/.oh-my-zsh
    fi
    log_download ".oh-my-zsh"
    curl -s https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o ${TMP_SCRIPT_DIR}/zshinstall.sh
    (RUNZSH="no" sh ${TMP_SCRIPT_DIR}/zshinstall.sh)

    ln -sf $SCRIPT_HOME/zshrc .zshrc
    log_ln ".zshrc"

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
. ${SCRIPT_HOME}/modules/git/install.sh
ins_zsh

# remove script tmp dir
rm -rf ${TMP_SCRIPT_DIR}

