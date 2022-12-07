set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &runtimepath.=', "~/.config/nvim/lua"'
let &packpath=&runtimepath

source ~/.vimrc
