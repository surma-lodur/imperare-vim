
set nocompatible              " be iMproved, required
filetype off                  " required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" ##################################
" ##  Platform specific settings  ##
" ##################################

if has('win32') || has('win64') || has('win32unix') || has('win95')
  let $PATH.= ';' . $HOME . '/_vim/bin'
  set runtimepath=$HOME/_vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/_vim/after

  set guifont=DejaVu_Sans_Mono_for_Powerline:h9:cANSI
  set backupdir=$HOME/_vim/backup
  set directory=$HOME/_vim/backup

  " ack grep
  let g:ackprg=$HOME . "/_vim/bin/ag.exe --nogroup --nocolor --column"

  call plug#begin('~/_vim/plugged')

  "helptags ~/_vim/doc/*
  "let g:vimrubocop_config = '~/_vim/rubocop.yml'

else
  set shell=/bin/sh

  " Directories for swp files
  set backupdir=~/.vim/backup
  set directory=~/.vim/backup

  call plug#begin('~/.vim/plugged')

  if has("mac") || has("gui_macvim")
    "set guifont=Liberation\ Mono\ for\ Powerline:h14
    set guifont=Hack\ Nerd\ Font\ Mono:h14
    let g:ackprg="ag --nocolor --nogroup --column"
    "helptags ~/.vim/doc/*
    "let g:vimrubocop_config = '~/.vim/rubocop.yml'

    if exists("+relativenumber")
      set norelativenumber
    endif

    set foldlevel=0
    set foldmethod=manual

  else
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
    " ack grep
    let g:ackprg="ag --nocolor --nogroup --column"
    "helptags ~/.vim/doc/*
    "let g:vimrubocop_config = '~/.vim/rubocop.yml'

  end
endif


" ###############
" ##  Plugins  ##
" ###############

Plug 'ctrlpvim/ctrlp.vim',      &diff ? {'on': []} : {} " File search by file name
Plug 'mileszs/ack.vim',         &diff ? {'on': []} : {} " Full text search via ack-grep or ag
Plug 'tomtom/tlib_vim'         " Needed for snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'taglist.vim'             " provides  a method tree per file
Plug 'bling/vim-airline'        " Colourfull status line

Plug 'jlanzarotta/bufexplorer', &diff ? {'on': []} : {} " Explore open files
Plug 'tpope/vim-git',           &diff ? {'on': []} : {} " Git Support
Plug 'tpope/vim-fugitive',      &diff ? {'on': []} : {} " f.e. git blame integration
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree',        &diff ? {'on': []} : {}     " Directory Tree

Plug 'chrisbra/vim-diff-enhanced', &diff ? {} : {'on': []}
"Plugin 'blueyed/vim-diminactive'
"Plugin 'powerman/vim-plugin-AnsiEsc.git'

" ########################
" ##  language support  ##
" ########################
Plug 'fatih/vim-go',               {'for': 'go'}            " Go-Lang
Plug 'vim-ruby/vim-ruby',          {'for': 'ruby'}
Plug 'rust-lang/rust.vim',         {'for': 'rust'}
"Plugin 'kchmck/vim-coffee-script', {for: 'coffee'}
Plug 'elixir-editors/vim-elixir',  {'for': 'elixir'}
Plug 'pangloss/vim-javascript',    {'for': ['js', 'javascript']}
Plug 'maxmellon/vim-jsx-pretty',   {'for': ['jsx', 'javascript', 'js']}
Plug 'stephpy/vim-yaml',           {'for': 'yaml'}
Plug 'leafgarland/typescript-vim', {'for': ['js', 'javascript', 'ts']}
"Plugin 'chrisbra/csv.vim'
"Plugin 'ap/vim-css-color'

if has('win32') || has('win64') || has('win32unix') || has('win95')
  Plug 'ervandew/supertab.git'
  Plug 'garbas/vim-snipmate.git'      
  "let g:SuperTabDefaultCompletionType    = '<Tab>'
  "let g:SuperTabCrMapping                = 0

else
  Plug 'ervandew/supertab'
  Plug 'garbas/vim-snipmate'      
  "Plugin 'valloric/youcompleteme' " TODO fix config with snippets
  "let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
  "let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']

  "imap <Tab> <C-P>
  " cd ~/.vim/bundle/YouCompleteMe
  " python3 install.py   --clang-completer  --go-completer 
endif

if executable('fd')
  let g:ctrlp_user_command = 'fd -c never "" %s'
  let g:ctrlp_use_caching = 0
endif

if version < 800
  Plug 'vim-syntastic/syntastic.git'     " Display synax errors of many languages
else
  Plug 'w0rp/ale'
endif



" ##############
" ##  themes  ##
" ##############

" Black
"Plugin 'sickill/vim-monokai.git'
"Plugin 'yantze/pt_black.git'

" Invertable color theme
"Plugin 'noahfrederick/vim-hemisu.git'
"Plugin 'rakr/vim-two-firewatch'
"Plugin 'mkarmona/materialbox.git'
Plug 'morhetz/gruvbox'

" light theme
"Plugin 'vim-scripts/summerfruit256.vim.git'
"Plugin 'vim-scripts/proton.git'

call plug#end()

filetype plugin indent on    " required
set omnifunc=syntaxcomplete#Complete

" #############################
" ##  General Configuration  ##
" #############################
nmap <D-v> "+gP
imap <D-v> <ESC><D-v>i
vmap <D-c> "+y 

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
"set lines=50 columns=100
set diffopt=filler,context:0

" GUI Settings
":set guioptions-=m  "remove menu bar
":set guioptions-=T  "remove toolbar
":set guioptions-=r  "remove right-hand scroll bar
":set lines=55 columns=150

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on


:" Use modeline overrides
set modeline
set modelines=10

  " Set cursor highlighting
  "set cursorline
  "set cursorcolumn

  " set line limit bar
  " VIM 7.3+ has support for highlighting a specified column.
  if exists('+colorcolumn')
    "set colorcolumn=140
  else
    "Emulate
    "au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%85v.\+', -1)
  endif



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
" let g:loaded_vimballPlugin = 1
" Convert current view to HTML
" let g:loaded_2html_plugin = 1

" ############################
" ##  Plugin Configuration  ##
" ############################

if version < 800
  set lazyredraw
  "set nolazyredraw
  "set nolazyredraw
  set ttyfast
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
  set lazyredraw
  "set nolazyredraw
  set ttyfast

  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_insert_leave = 1
  let g:ale_lint_on_enter = 0
  let g:ale_lint_delay = 500
  let g:ale_completion_enabled = 1
  let g:ale_fix_on_save = 0
  let g:ale_cache_executable_check_failures=1
  let g:ale_linters = {
        \ 'elixir':     ['dialyxir'],
        \ }


  let g:ale_fixers = {
        \ 'javascript': ['eslint', 'prettier'], 
        \ 'ruby':       ['rubocop'],
        \ 'css':        ['csslint'],
        \ 'go':         ['gofmt'],        
        \ 'elixir':     ['mix_format'],
        \ }
  " , 'eslint'],
  let g:airline#extensions#ale#enabled = 1
endif

"let g:diminactive_use_colorcolumn = 0
"let g:diminactive_use_syntax = 1

"let g:UltiSnipsExpandTrigger="<Tab>"
"let g:UltiSnipsJumpForwardTrigger="<Tab>"                                           
"let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
"

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

" ruby
let ruby_no_expensive=1
" set re=1
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
map <F8> :!ctags -R -n --fields=+i+K+S+l+m+a <CR>

map <leader>b :BufExplorer<CR>
map <F12> :BufExplorer<CR>

" Displays the tag list, this is a list of used Methods/constants which are
" currently open into vim
map <leader>m :TlistToggle<CR>

" switch theme
nmap <F5> :set background=dark<CR>
nmap <F6> :set background=light<CR>
nmap <F7> :hi Normal ctermbg=none<CR>:highlight NonText ctermbg=none<CR>
nmap <F8> :hi Normal ctermbg=214<CR>:highlight NonText ctermbg=214<CR>

nmap <F8> :execute ":color ".g:colors_name <CR>

" Golang
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType xml nnoremap <leader>x :%!xmllint --format -<CR>
au FileType json nnoremap <leader>x :%!jq .<CR>

map <F4> :%s/\s\+$//e


" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

if filereadable(expand("$HOME/_vimrc.local"))
  source $HOME/_vimrc.local
endif


let g:gruvbox_contrast_dark='high'
let g:gruvbox_contrast_light='high'
"let g:gruvbox_italic = 1

colorscheme gruvbox

set background=light


nnoremap <leader>q :let g:ale_fix_on_save = 1<cr>
nnoremap <leader>a :let g:ale_fix_on_save = 0<cr>

let g:NERDTreeNodeDelimiter = "\u00a0"

" :let $RBENV_VERSION="2.3.8"
set tabstop=2 shiftwidth=2 expandtab
set mmp=5000
let g:go_version_warning = 0
