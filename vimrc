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
if has('win32') || has('win64') || has('win32unix') || has('win95')
  Plug 'ervandew/supertab.git'
  Plug 'garbas/vim-snipmate.git'

else
  let ruby_version = system('ruby -v')
  let new_ruby = matchstr(ruby_version, 'ruby\s[2-9]\.[2-9]\.')

  if &diff
  else
    if has('nvim')
      Plug 'neovim/nvim-lspconfig'
      Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main'}
      Plug 'hrsh7th/cmp-buffer', { 'branch': 'main'}
      Plug 'hrsh7th/cmp-path', { 'branch': 'main'}
      Plug 'hrsh7th/cmp-cmdline', { 'branch': 'main'}
      Plug 'hrsh7th/nvim-cmp', { 'branch': 'main'}

      Plug 'hrsh7th/cmp-vsnip', { 'branch': 'main'}
      Plug 'hrsh7th/vim-vsnip', { 'branch': 'main'}

    else
      Plug 'metalelf0/supertab',  empty(new_ruby)  ? {} : {'on': []}
      Plug 'garbas/vim-snipmate', empty(new_ruby) ? {} : {'on': []}
      Plug 'neoclide/coc.nvim',   empty(new_ruby) ? {'on': [], 'branch': 'release'} : {'branch': 'release'}
    endif
  endif

  if empty(new_ruby)
  else
    if has('nvim')
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
endif


Plug 'ctrlpvim/ctrlp.vim',      &diff ? {'on': []} : {'on': 'CtrlP'} " File search by file name
Plug 'yegappan/grep',           &diff ? {'on': []} : {} " Full text search via ack-grep or ag
Plug 'tomtom/tlib_vim',         &diff ? {'on': []} : {} " Needed for snipmate
Plug 'MarcWeber/vim-addon-mw-utils', &diff ? {'on': []} : {}
"Plug 'vim-scripts/taglist.vim'  " provides  a method tree per file
Plug 'preservim/tagbar',        &diff ? {'on': []} : {}
Plug 'bling/vim-airline',       &diff ? {'on': []} : {} " Colourfull status line
Plug 'dense-analysis/ale',                &diff ? {'on': []} : {}

Plug 'jlanzarotta/bufexplorer', &diff ? {'on': []} : {} " Explore open files
Plug 'tpope/vim-git',           &diff ? {'on': []} : {} " Git Support
Plug 'tpope/vim-fugitive',      &diff ? {'on': []} : {'on': 'Gblame'} " f.e. git blame integration
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree',                        &diff ? {'on': []} : {'on': 'NERDTreeToggle'}     " Directory Tree
Plug 'ryanoasis/vim-devicons',                    &diff ? {'on': []} : {} " Directory Tree
Plug 'lambdalisue/glyph-palette.vim',             &diff ? {'on': []} : {} " Directory Tree


Plug 'chrisbra/vim-diff-enhanced', &diff ? {} : {'on': []}
"Plug 'powerman/vim-plugin-AnsiEsc.git'


" ########################
" ##  language support  ##
" ########################
Plug 'fatih/vim-go',               {'for': 'go'}            " Go-Lang
Plug 'vim-ruby/vim-ruby',          {'for': 'ruby'}
Plug 'rust-lang/rust.vim',         {'for': 'rust'}
Plug 'elixir-editors/vim-elixir',  {'for': 'elixir'}
Plug 'pangloss/vim-javascript',    {'for': ['js', 'javascript']}
Plug 'maxmellon/vim-jsx-pretty',   {'for': ['jsx', 'javascript', 'js']}
Plug 'stephpy/vim-yaml',           {'for': 'yaml'}
Plug 'leafgarland/typescript-vim', {'for': ['js', 'javascript', 'ts']}
Plug 'ap/vim-css-color',           {'for': ['html', 'haml', 'css']}
"Plugin 'kchmck/vim-coffee-script', {for: 'coffee'}
"Plugin 'chrisbra/csv.vim'


if executable('fd')
  let g:ctrlp_user_command = 'fd -c never "" %s'
  let g:ctrlp_use_caching = 0
endif

if &diff
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
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
Plug 'gruvbox-community/gruvbox'

" light theme
"Plugin 'vim-scripts/summerfruit256.vim.git'
"Plugin 'vim-scripts/proton.git'

call plug#end()

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
au BufNewFile,BufRead *.{json,node} set ft=javascript

" arduino
au BufNewFile,BufRead *.ino set ft=cpp

if has('nvim')

  lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
    },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
    },
  mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
sources = cmp.config.sources({
{ name = 'nvim_lsp' },
{ name = 'vsnip' }, -- For vsnip users.
-- { name = 'luasnip' }, -- For luasnip users.
-- { name = 'ultisnips' }, -- For ultisnips users.
-- { name = 'snippy' }, -- For snippy users.
}, {
{ name = 'buffer' },
})
  })

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
  { name = 'buffer' },
  })
})

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
      }
    })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
    { name = 'path' }
    }, {
    { name = 'cmdline' }
    })
  })

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  capabilities = capabilities
  }
EOF
endif

" ############################
" ##  Plugin Configuration  ##
" ############################

if version < 800
  set lazyredraw
  set ttyfast
  "Syntax Checker
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

else
  set lazyredraw
  set ttyfast

  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_insert_leave = 1
  let g:ale_lint_on_enter = 0
  let g:ale_lint_delay = 500
  let g:ale_completion_enabled = 1
  let g:ale_fix_on_save = 1
  let g:ale_cache_executable_check_failures=1
  let g:ale_sign_error = '❗'
  let g:ale_sign_warning = '⚠️ '
  let g:ale_linters = {
        \ 'elixir':     ['dialyxir'],
        \ }


  let g:ale_fixers = {
        \ '*': ['remove_trailing_lines', 'trim_whitespace'],
        \ 'javascript': ['eslint', 'prettier'],
        \ 'ruby':       ['rubocop'],
        \ 'css':        ['csslint', 'prettier'],
        \ 'html':       ['prettier'],
        \ 'go':         ['gofmt'],
        \ 'elixir':     ['mix_format'],
        \ 'sh':         ['shfmt'],
        \ 'bash':       ['shfmt'],
        \ }
  " , 'eslint'],
  let g:airline#extensions#ale#enabled = 1
  let g:ale_ruby_rubocop_executable = 'bundle'
endif


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

map <F2> :Fern . -drawer -stay<CR>
"map <F2> :Vexplore<CR>
"map <F2> :NERDTreeToggle<CR>
"map <C-N> :NERDTreeFind<cr>
map <Leader>n :NERDTreeToggle<CR>

" ctags tags file generation for the current directory
map <F8> :!ctags -R -n --fields=+i+K+S+l+m+a <CR>

" Displays the tag list, this is a list of used Methods/constants which are
" currently open into vim
"map <leader>m :TlistToggle<CR>
map <leader>m :TagbarToggle<CR>

map <leader>b :BufExplorer<CR>
map <F12> :BufExplorer<CR>


" switch theme
nmap <F5> :set background=dark<CR>
nmap <F6> :set background=light<CR>
nmap <F7> :hi Normal ctermbg=none<CR>:highlight NonText ctermbg=none<CR>
nmap <F8> :hi Normal ctermbg=214<CR>:highlight NonText ctermbg=214<CR>

nmap <F8> :execute ":color ".g:colors_name <CR>

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

set background=dark
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

let g:fern#renderer = "devicons"
"function! s:init_fern() abort
"    nmap <buffer> <left> <Plug>(fern-action-expand)
"    nmap <buffer> <right> <Plug>(fern-action-collapse)
"endfunction

nnoremap <leader>q :let g:ale_fix_on_save = 1<cr>
nnoremap <leader>a :let g:ale_fix_on_save = 0<cr>


" :let $RBENV_VERSION="2.6.6"
set tabstop=2 shiftwidth=2 expandtab
set mmp=5000
let g:go_version_warning = 0
