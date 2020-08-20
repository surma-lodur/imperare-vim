#!/usr/bin/env bash

ln -sf `pwd`/vim $HOME/.vim
ln -sf `pwd`/vimrc $HOME/.vimrc
mkdir -p $HOME/.config/nvim/

ln -sf `pwd`/nvim/init.vim $HOME/.config/nvim/

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.st "status"
git config --global alias.co "checkout"

