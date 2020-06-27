#!/usr/bin/env bash

log_ins "neoVim"
if [ -f $HOME/.config/nvim/init.vim ]; then
    log_rm "$HOME/.config/nvim/init.vim"
    rm $HOME/.config/nvim/init.vim
fi

log_download "Plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -sf $SCRIPT_HOME/modules/nvim/nivm $HOME/.config/nvim
log_ln "$HOME/.config/nvim"

log_ins_end


