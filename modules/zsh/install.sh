#!/usr/bin/env bash

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

ln -sf $SCRIPT_HOME/modules/zsh/zshrc .zshrc
log_ln ".zshrc"

log_ins_end
