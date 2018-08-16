
set nocompatible              " be iMproved, required
filetype off                  " required

" ##################################
" ##  Platform specific settings  ##
" ##################################

if has('win32') || has('win64') || has('win32unix') || has('win95')
  let $PATH.= ';' . $HOME . '/_vim/bin'
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

  "Plugin 'PProvost/vim-ps1.git'   " Syntax Highlighting for PowerShell
  "helptags ~/_vim/doc/*
  let g:vimrubocop_config = '~/_vim/rubocop.yml'

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
  let g:ackprg="ag --nocolor --nogroup --column"
  "helptags ~/.vim/doc/*
  let g:vimrubocop_config = '~/.vim/rubocop.yml'
endif

" ###############
" ##  Plugins  ##
" ###############

Plugin 'VundleVim/Vundle.vim'        " Plugin Manager
Plugin 'ctrlpvim/ctrlp.vim.git'          " File search by file name
Plugin 'mileszs/ack.vim.git'         " Full text search via ack-grep or ag
Plugin 'tomtom/tlib_vim.git'         " Needed for snipmate
Plugin 'MarcWeber/vim-addon-mw-utils.git'
Plugin 'garbas/vim-snipmate.git'      "
" Plugin 'honza/vim-snippets'         " Enable this to get some predefined Snippets for different languages
Plugin 'taglist.vim'                  " provides  a method tree per file
Plugin 'ervandew/supertab.git'
Plugin 'bling/vim-airline.git'        " Colourfull status line

Plugin 'firat/vim-bufexplorer.git'    " Explore open files
Plugin 'tpope/vim-git.git'            " Git Support
Plugin 'tpope/vim-fugitive.git'       " f.e. git blame integration
Plugin 'scrooloose/nerdcommenter.git' " commenting functionality
Plugin 'scrooloose/nerdtree.git'          " Directory Tree

"Plugin 'ngmy/vim-rubocop.git'         " autoformat Ruby Code

" ########################
" ##  language support  ##
" ########################
Plugin 'fatih/vim-go.git'             " Go-Lang
"Plugin 'othree/yajs.vim.git'          " Javascript
Plugin 'stephpy/vim-yaml.git'
Plugin 'isRuslan/vim-es6'
Plugin 'kchmck/vim-coffee-script'


if v:version < 800
  Plugin 'vim-syntastic/syntastic.git'     " Display synax errors of many languages
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
  let g:syntastic_javascript_checkers=['eslint']

  "let g:syntastic_ruby_checkers = ['rubocop', 'mri' ]
else
  Plugin 'w0rp/ale'
  let g:ale_lint_delay = 1000
  let g:ale_fix_on_save = 1
  let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'ruby': ['rubocop']}
  let g:airline#extensions#ale#enabled = 1
endif
"Plugin 'chrisbra/csv.vim'

" ##############
" ##  themes  ##
" ##############

" Black
Plugin 'sickill/vim-monokai.git'
"Plugin 'yantze/pt_black.git'

" Invertable color theme
"Plugin 'noahfrederick/vim-hemisu.git'
"Plugin 'rakr/vim-two-firewatch'
"Plugin 'mkarmona/materialbox.git'
Plugin 'morhetz/gruvbox'

" light theme
"Plugin 'vim-scripts/summerfruit256.vim.git'
"Plugin 'vim-scripts/proton.git'

call vundle#end()
filetype plugin indent on    " required


" ############################
" ##  Plugin Configuration  ##
" ############################

"colorscheme summerfruit256
colorscheme gruvbox
"let g:gruvbox_italic = 0

set background=dark

if v:version < 800
  "set lazyredraw
  "set nolazyredraw
  "set nolazyredraw
  "set ttyfast
else
  "set nolazyredraw
endif

set number
set ruler
syntax on

set encoding=utf-8      " Set encoding
set nofoldenable    " disable folding

" Whitespace stuff
set wrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
"set list listchars=tab:\ \ ,trail:·
"set listchars=tab:>·,trail:~,extends:>,precedes:<
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" Set cursor highlighting
set cursorline
"set cursorcolumn


" GUI Settings
":set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set lines=55 columns=150

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on


" Use modeline overrides
set modeline
set modelines=10

" set line limit bar
" VIM 7.3+ has support for highlighting a specified column.
"if exists('+colorcolumn')
  "set colorcolumn=140
"else
   "Emulate
  "au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%85v.\+', -1)
"endif

hi Normal ctermbg=none
highlight NonText ctermbg=none


" Vertical split right and split below
set splitright
set splitbelow

" ##############################
" ##  Own Syntax Definitions  ##
" ##############################

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Guardfile,Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
"au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.{json,node} set ft=javascript

" arduino
au BufNewFile,BufRead *.ino set ft=cpp

" #######################
" ##  Disable Plugins  ##
" #######################

" Manage Script packages vba
let g:loaded_vimballPlugin = 1
" Convert current view to HTML
let g:loaded_2html_plugin = 1

" ############################
" ##  Plugin Configuration  ##
" ############################

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/plugins/*,temp_gems/*,tmp/*,public/*,.bundler/*

" CtrlP config
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.orig,*.org,*.jpg,*.png,*.gif,*.svg,*.swf,*.mp4*,*.flv
let g:ctrlp_custom_ignore = {
      \'dir':  '\v[\/]((\.(git|hg|svn))|public|tmp|temp|log|logs)$',
      \'file': '\v\.(exe|so|dll|orig)$'
      \}

" Status bar - Airline
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_enable_fugitive=1

" NERDTree - toggle
" Open the current buffer in the NERDTree
let NERDTreeIgnore=['\.rbc$', '\~$']

" Buff Explorere
let g:bufExplorerSortBy='mru'

" configure taglist.vim
let Tlist_Compact_Format = 1
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Update = 1
let Tlist_WinWidth = 50

" netrw configure
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 10
"augroup ProjectDrawer
  "autocmd!
  "autocmd VimEnter * :Vexplore
"augroup END

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

" Copy paste to system clipboard
map <leader>x  "+y
map <leader>v  "+gP

map <F2> :Vexplore<CR>
"map <F2> :NERDTreeToggle<CR>
"map <C-N> :NERDTreeFind<cr>
map <Leader>n :NERDTreeToggle<CR>

" ctags tags file generation for the current directory
map <F8> :!ctags -R .<CR>

map <leader>b :BufExplorer<CR>
map <F12> :BufExplorer<CR>

" Displays the tag list, this is a list of used Methods/constants which are
" currently open into vim
map <leader>m :TlistToggle<CR>

" switch theme
nmap <F5> :set background=dark<CR>
nmap <F6> :set background=light<CR>
nmap <F7> :hi Normal ctermbg=none<CR>:highlight NonText ctermbg=none<CR>

"function ResetColorScheme()
  "let reset_color= g:colors_name
  "hi Normal ctermbg=256
  "highlight NonText ctermbg=256
  "color default
  "execute ":color ".reset_color
"endfunction

nmap <F8> :execute ":color ".g:colors_name <CR>

" Golang
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

map <F4> :%s/\s\+$//e

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

if filereadable(expand("$HOME/_vimrc.local"))
  source $HOME/_vimrc.local
endif
