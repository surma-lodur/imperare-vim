let $PATH.= ';' . $HOME . '/_vim/bin'

set nocompatible              " be iMproved, required
filetype off                  " required

" ##################################
" ##  Platform specific settings  ##
" ##################################

if has('win32') || has('win64')
  set runtimepath=$HOME/_vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/_vim/after

  " Textile config
  let g:TextileOS="Windows"
  let g:TextileBrowser="edge.exe"

  set guifont=DejaVu_Sans_Mono_for_Powerline:h9:cANSI
  set backupdir=$HOME/_vim/backup
  set directory=$HOME/_vim/backup
  " vundle support
  set rtp+=$HOME/_vim/bundle/Vundle.vim

  let path='~/_vim/bundle'

  " ack grep
  let g:ackprg=$HOME . "/_vim/bin/ag.exe --nogroup --nocolor --column"

  call vundle#begin(path)

  Plugin 'PProvost/vim-ps1.git'   " Syntax Highlighting for PowerShell

else

  set shell=/bin/sh

  " Textile config
  let g:TextileOS="Linux"
  let g:TextileBrowser="chromium-browser"

  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9

  " Directories for swp files
  set backupdir=~/.vim/backup
  set directory=~/.vim/backup

  " vundle support
  set rtp+=~/.vim/bundle/Vundle.vim

  call vundle#begin()

  " ack grep
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif

" ###############
" ##  Plugins  ##
" ###############

Plugin 'VundleVim/Vundle.vim'       " Plugin Manager
Plugin 'kien/ctrlp.vim.git'         " File search by file name
Plugin 'mileszs/ack.vim.git'        " Full text search via ack-grep or ag
Plugin 'tomtom/tlib_vim.git'
Plugin 'MarcWeber/vim-addon-mw-utils.git'
Plugin 'garbas/vim-snipmate.git'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab.git'
Plugin 'bling/vim-airline.git'        " Colourfull status line
Plugin 'taglist.vim'                  " provides  a method tree per file

Plugin 'firat/vim-bufexplorer.git'    " Explore open files
Plugin 'tpope/vim-git.git'            " Git Support
Plugin 'tpope/vim-fugitive.git'       " f.e. git blame integration
Plugin 'scrooloose/nerdcommenter.git' " commenting functionality
Plugin 'wycats/nerdtree.git'          " Directory Tree

" ########################
" ##  language support  ##
" ########################
Plugin 'fatih/vim-go.git'             " Go-Lang
Plugin 'othree/yajs.vim.git'          " Javascript
Plugin 'timcharper/textile.vim.git'   " Textile
Plugin 'scrooloose/syntastic.git'     " Display synax errors of many languages

" ##############
" ##  themes  ##
" ##############

" Black
Plugin 'sickill/vim-monokai.git'
Plugin 'yantze/pt_black.git'

" Invertable color theme
Plugin 'noahfrederick/vim-hemisu.git'
Plugin 'rakr/vim-two-firewatch'

Plugin 'mkarmona/materialbox.git'

" light theme
Plugin 'vim-scripts/summerfruit256.vim.git'
Plugin 'vim-scripts/proton.git'


call vundle#end()
filetype plugin indent on    " required


" ############################
" ##  Plugin Configuration  ##
" ############################

colorscheme pt_black

set number
set ruler
syntax on

set encoding=utf-8      " Set encoding

" Whitespace stuff
set wrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·


" Searching
"set hlsearch
"set incsearch
"set ignorecase
"set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/plugins/*,temp_gems/*,tmp/*,public/*,.bundler/*

" Status bar
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_enable_fugitive=1

" own syntax definitions

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Guardfile,Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
"au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.{json,node} set ft=javascript

" arduino
au BufNewFile,BufRead *.ino set ft=cpp

au BufRead,BufNewFile *.txt call s:setupWrapping()


" CtrlP config
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.orig,*.org,*.jpg,*.png,*.gif,*.svg,*.swf,*.mp4*,*.flv
let g:ctrlp_custom_ignore = {
      \'dir':  '\v[\/]((\.(git|hg|svn))|public|tmp|temp|log|logs)$',
      \'file': '\v\.(exe|so|dll|orig)$'
      \}

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on


" Use modeline overrides
set modeline
set modelines=10



" Vertical split right and split below
set splitright
set splitbelow


" NERDTree - toggle
" Open the current buffer in the NERDTree
let NERDTreeIgnore=['\.rbc$', '\~$']

" Buff Explorere
let g:bufExplorerSortBy='mru'

" configure taglist.vim
let Tlist_Compact_Format = 1
let Tlist_Use_Right_Window = 0
let Tlist_Auto_Update = 1
let Tlist_WinWidth = 50


" set line limit bar
" VIM 7.3+ has support for highlighting a specified column.
if exists('+colorcolumn')
  set colorcolumn=140
else
  " Emulate
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%85v.\+', -1)
endif

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

if filereadable(expand("$HOME/_vimrc.local"))
  source $HOME/_vimrc.local
endif

" GUI Settings
":set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
":set guioptions-=r  "remove right-hand scroll bar
"
"
"Syntax Checker
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


" ####################
" ##  key mappings  ##
" ####################


" Leader setting
let mapleader = ","

" Open files with <leader>f
map <leader>f :CtrlP<cr>

" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found below.
map <leader>gf :CtrlP %%<cr>

" Open files limited to a specific rails-path
map <leader>gv :CtrlP app/views<cr>
map <leader>gc :CtrlP app/controllers<cr>
map <leader>gm :CtrlP app/models<cr>
map <leader>gh :CtrlP app/helpers<cr>
map <leader>gl :CtrlP lib<cr>
map <leader>gp :CtrlP public<cr>
map <leader>gs :CtrlP spec<cr>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>


" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>


" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Jumping between windows
map <C-H> <C-W><C-H>
map <C-L> <C-W><C-L>
map <C-J> <C-W><C-J>
map <C-K> <C-W><C-K>

map <leader>n :bn
map <leader>p :bp

" Copy paste to system clipboard
map <leader>x  "+y
map <leader>v  "+gP
map <c-c> "+y
map <c-v>  "+gP


"map <C-N> :NERDTreeFind<cr>
map <F2> :NERDTreeToggle<CR>
map <Leader>n :NERDTreeToggle<CR>

" ctags tags file generation for the current directory
map <F8> :!ctags -R .<CR>

map <leader>b :BufExplorer<CR>
map <F12> :BufExplorer<CR>

" Displays the tag list, this is a list of used Methods/constants which are
" currently open into vim
map <leader>m :TlistToggle<CR>

" Golang
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)



" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
