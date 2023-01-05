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

else
  set shell=$SHELL

  " Directories for swp files
  set backupdir=~/.vim/backup
  set directory=~/.vim/backup

  call plug#begin('~/.vim/plugged')

  if has("mac") || has("gui_macvim")
    if !has("nvim")
    let $VIMRUNTIME=system('echo -n $(brew --prefix vim )/share/vim/vim*/')
    end
    "set guifont=Liberation\ Mono\ for\ Powerline:h14
    set guifont=Hack\ Nerd\ Font\ Mono:h14
    let g:ackprg="ag --nocolor --nogroup --column"

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

  end
endif

" ###############
" ##  Plugins  ##
" ###############


let g:snipMate = { 'snippet_version' : 0 }
let ruby_version = system('ruby -v')
let new_ruby = matchstr(ruby_version, 'ruby\s[2-9]\.[2-9]\.')

if &diff
  if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main'}
    Plug 'hrsh7th/cmp-buffer', { 'branch': 'main'}
    Plug 'hrsh7th/cmp-path', { 'branch': 'main'}
    Plug 'hrsh7th/cmp-cmdline', { 'branch': 'main'}
    Plug 'hrsh7th/nvim-cmp', { 'branch': 'main'}

    Plug 'hrsh7th/cmp-vsnip', { 'branch': 'main'}
    Plug 'hrsh7th/vim-vsnip', { 'branch': 'master'}
    let g:LanguageClient_useVirtualText = 0
  endif

else
  if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main'}
    Plug 'hrsh7th/cmp-buffer', { 'branch': 'main'}
    Plug 'hrsh7th/cmp-path', { 'branch': 'main'}
    Plug 'hrsh7th/cmp-cmdline', { 'branch': 'main'}
    Plug 'hrsh7th/nvim-cmp', { 'branch': 'main'}

    Plug 'hrsh7th/cmp-vsnip', { 'branch': 'main'}
    Plug 'hrsh7th/vim-vsnip', { 'branch': 'master'}
    let g:LanguageClient_useVirtualText = 0

  else
    Plug 'tomtom/tlib_vim',         &diff ? {'on': []} : {} " Needed for snipmate
    Plug 'metalelf0/supertab',  empty(new_ruby)  ? {} : {'on': []}
    Plug 'garbas/vim-snipmate', empty(new_ruby) ? {} : {'on': []}
    Plug 'neoclide/coc.nvim',   empty(new_ruby) ? {'on': [], 'branch': 'release'} : {'branch': 'release'}
  endif
endif

if empty(new_ruby)
else
  if has('nvim')
    "inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    "inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  else
    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
  endif
endif
let g:deoplete#enable_at_startup = 1


if has('nvim')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim' " File search by file name
  Plug 'nvim-lualine/lualine.nvim' " Colourfull status line

  Plug 'mileszs/ack.vim',           &diff ? {'on': []} : {}
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

  Plug 'sindrets/diffview.nvim' ", &diff ? {} : {'on': []}
  Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
  Plug 'nvim-tree/nvim-tree.lua'

else
  Plug 'ctrlpvim/ctrlp.vim',      &diff ? {'on': []} : {'on': 'CtrlP'} " File search by file name
  Plug 'bling/vim-airline',       &diff ? {'on': []} : {} " Colourfull status line

  Plug 'chrisbra/vim-diff-enhanced', &diff ? {} : {'on': []}
  Plug 'yegappan/grep',           &diff ? {'on': []} : {} " Full text search via ack-grep or ag
  Plug 'preservim/nerdtree',                        &diff ? {'on': []} : {'on': 'NERDTreeToggle'}     " Directory Tree

  if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
  endif
endif
Plug 'MarcWeber/vim-addon-mw-utils', &diff ? {'on': []} : {}
Plug 'preservim/tagbar',        &diff ? {'on': []} : {}
Plug 'dense-analysis/ale',                &diff ? {'on': []} : {}

Plug 'jlanzarotta/bufexplorer', &diff ? {'on': []} : {} " Explore open files
Plug 'tpope/vim-fugitive',      &diff ? {'on': []} : {} " f.e. git blame integration
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons',                    &diff ? {'on': []} : {} " Directory Tree
Plug 'lambdalisue/glyph-palette.vim',             &diff ? {'on': []} : {} " Directory Tree

Plug 'vim-scripts/AnsiEsc.vim'

"Plug 'powerman/vim-plugin-AnsiEsc.git'



" ########################
" ##  language support  ##
" ########################
"
if has('nvim')
else
  Plug 'fatih/vim-go',               {'for': 'go'}            " Go-Lang
  Plug 'vim-ruby/vim-ruby',          {'for': 'ruby'}
  Plug 'rust-lang/rust.vim',         {'for': 'rust'}
  Plug 'elixir-editors/vim-elixir',  {'for': 'elixir'}
  Plug 'pangloss/vim-javascript',    {'for': ['js', 'javascript']}
  Plug 'maxmellon/vim-jsx-pretty',   {'for': ['jsx', 'javascript', 'js']}
  Plug 'stephpy/vim-yaml',           {'for': 'yaml'}
  Plug 'leafgarland/typescript-vim', {'for': ['js', 'javascript', 'ts']}
  Plug 'kchmck/vim-coffee-script',   {'for': 'coffee'}
endif
Plug 'ap/vim-css-color',           {'for': ['html', 'haml', 'css']}



" ##############
" ##  themes  ##
" ##############


" Invertable color theme
"Plug 'rakr/vim-two-firewatch'
"Plug 'mkarmona/materialbox.git'
Plug 'gruvbox-community/gruvbox'

let g:gruvbox_contrast_dark='high'
let g:gruvbox_contrast_light='high'
"let g:gruvbox_italic = 1

call plug#end()

set completeopt=menu,menuone,noselect


colorscheme gruvbox

set background=dark

let current_hour=strftime("%H")
if current_hour >= 21
  set background=dark
  let g:gruvbox_contrast_dark='medium'
elseif current_hour >= 16
  set background=dark
  let g:gruvbox_contrast_dark='high'

elseif current_hour >= 9
  set background=light
  let g:gruvbox_contrast_light='high'
else
  set background=light
  let g:gruvbox_contrast_light='soft'
endif


filetype plugin indent on    " required

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
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set diffopt=filler,context:0

"set updatetime=1000
"set shortmess+=c

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
set cursorline
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
" au BufNewFile,BufRead *.{json,node} set ft=javascript

" arduino
au BufNewFile,BufRead *.ino set ft=cpp

if has('nvim')
  set mouse=
  lua require('config')
  let g:vsnip_snippet_dir= '~/.vim/snippets'
endif

" ############################
" ##  Plugin Configuration  ##
" ############################

set lazyredraw
set ttyfast

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_delay = 500
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1
let g:ale_cache_executable_check_failures=1
let g:ale_virtualtext_cursor = 0
let g:ale_sign_error = '❗'
let g:ale_sign_warning = '⚠️ '
let g:ale_linters = {
      \ 'elixir':     ['dialyxir'],
      \ 'go':         ['golangci-lint']
      \ }


let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['eslint', 'prettier'],
      \ 'ruby':       ['rubocop'],
      \ 'css':        ['csslint', 'prettier'],
      \ 'html':       ['prettier'],
      \ 'go':         ['gofumpt'],
      \ 'c':          ['clang-format', 'astyle', 'clangtidy'],
      \ 'elixir':     ['mix_format'],
      \ 'json':       ['fixjson'],
      \ 'sh':         ['shfmt'],
      \ 'bash':       ['shfmt'],
      \ }
" , 'eslint'],
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_go_golangci_lint_options = ' --fast '


nnoremap <leader>r :let g:ale_fix_on_save = 1<cr>
nnoremap <leader>R :let g:ale_fix_on_save = 0<cr>


" CtrlP config
" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/plugins/*,temp_gems/*,tmp/*,public/*,.bundler/*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.orig,*.org,*.jpg,*.png,*.gif,*.svg,*.swf,*.mp4*,*.flv
let g:ctrlp_custom_ignore = {
      \'dir':  '\v[\/]((\.(git|hg|svn))|public|tmp|temp|log|logs)$',
      \'file': '\v\.(exe|so|dll|orig)$'
      \}

" Status bar - Airline
set laststatus=2
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts=1
let g:airline_enable_fugitive=1

" Buff Explorere
let g:bufExplorerSortBy='mru'

" configure taglist.vim
let Tlist_Compact_Format = 1
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Update = 1
let Tlist_WinWidth = 50

" configure tagbar
let g:tagbar_compact=1
let g:tagbar_show_visibility =1
let g:tagbar_indent = 1
let g:tagbar_width = max([25, winwidth(0) / 3])
let g:tagbar_wrap = 1

" netrw configure
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 10

let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:DevIconsEnableFoldersOpenClose = 1

set tabstop=2 shiftwidth=2 expandtab
set mmp=5000
let g:go_version_warning = 0


" ####################
" ##  key mappings  ##
" ####################

" Leader setting
let mapleader = ","

if has('nvim')
  nnoremap <leader>f <cmd>Telescope find_files<cr>
  nnoremap <leader>g <cmd>Telescope live_grep<cr>
else
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
endif

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

if has('nvim')
map <F2> :NvimTreeToggle<CR>
map <Leader>n :NvimTreeToggle<CR>
else
map <F2> :NERDTreeToggle<CR>
map <Leader>n :NERDTreeToggle<CR>
endif

" ctags tags file generation for the current directory
map <F3> :!ctags -R -n --fields=+i+K+S+l+m+a <CR>

" Displays the tag list, this is a list of used Methods/constants which are
" currently open into vim
"map <leader>m :TlistToggle<CR>
map <leader>m :TagbarToggle<CR>

map <leader>b :BufExplorer<CR>
map <F12> :BufExplorer<CR>


" switch theme
nmap <F5> :let g:gruvbox_contrast_dark='soft' <CR>:set background=dark<CR>
nmap <F6> :let g:gruvbox_contrast_dark='medium' <CR>:set background=dark<CR>
nmap <F7> :let g:gruvbox_contrast_dark='hard' <CR>:set background=dark<CR>
nmap <F8> :let g:gruvbox_contrast_light='soft' <CR>:set background=light<CR>
nmap <F9> :let g:gruvbox_contrast_light='medium' <CR>:set background=light<CR>
nmap <F10> :let g:gruvbox_contrast_light='hard' <CR>:set background=light<CR>

nmap <F11> :hi Normal guibg=NONE ctermbg=NONE<CR>
" nmap <F8> :execute ":color ".g:colors_name <CR>

au FileType xml nnoremap <leader>x :%!xmllint --format -<CR>
au FileType json nnoremap <leader>x :%!jq .<CR>

map <F4> :%s/\s\+$//e



augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END


" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

if filereadable(expand("$HOME/_vimrc.local"))
  source $HOME/_vimrc.local
endif


augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:DevIconsEnableFoldersOpenClose = 1



" :let $RBENV_VERSION="2.6.6"
set tabstop=2 shiftwidth=2 expandtab
set mmp=5000
let g:go_version_warning = 0
