set nocompatible              " Needs to be improved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'

" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" Docker highlighting
Plugin 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}


" clojure
"Plugin 'tpope/vim-fireplace'
"Plugin 'tpope/vim-classpath'
Plugin 'guns/vim-clojure-static'
Plugin 'vim-scripts/paredit.vim'
Plugin 'kien/rainbow_parentheses.vim'
"Plugin 'tpope/vim-leiningen'

" git
" Plugin 'gregsexton/gitv'
" Plugin 'tpope/vim-git'
" Plugin 'tpope/vim-fugitive'
"Plugin 'airblade/vim-gitgutter' 

" colorschemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'endel/vim-github-colorscheme'
Plugin 'jgdavey/vim-railscasts'
Plugin 'jpo/vim-railscasts-theme'
Plugin 'therubymug/vim-pyte'
Plugin 'tpope/vim-vividchalk'
Plugin 'croaker/mustang-vim'
Plugin 'wgibbs/vim-irblack'
Plugin 'ratazzi/blackboard.vim'
Plugin 'desert-warm-256'
Plugin 'sickill/vim-monokai'
Plugin 'flazz/vim-colorschemes'

" Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
" Plugin 'vim-scripts/SearchComplete'
" Plugin 'morhetz/gruvbox'
Plugin 'captbaritone/better-indent-support-for-php-with-html'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required: activates filetype detection
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" COLOR SCHEMES:
set background=dark

" colorscheme desert-warm-256
colorscheme blackboard
" colorscheme solarized

if &t_Co > 2 || has("gui_running")
  " Enable syntax highlighting
  syntax on
endif


"if has('gui_running')
"    colorscheme ratazzi
"elseif &t_Co > 255 
"    " xterm-256color
"    colorscheme terminal
"else
"    " xterm-color
"    colorscheme default
"endif
   
" settings needed for solarized colorscheme
"syntax enable
"set background=dark
"let g:solarized_termcolors=256
"colorscheme solarized

" activates syntax highlighting among other things
" syntax on

" allows you to deal with multiple unsaved
" buffers simultaneously without resorting
" to misusing tabs
set hidden

" just hit backspace without this one and
" see for yourself
set backspace=indent,eol,start

" Never set this in this file. It screws things up.
" set paste

" TABS AND SPACES

set tabstop=4 " The width of a TAB is set to 4.
              " Still it is a \t. It is just that
              " Vim will interpret it to be having
              " a width of 4.
set softtabstop=0 " Sets the number of columns for a TAB
set expandtab " Indents will have a width of 4
set shiftwidth=4 " Indents will have a width of 4
set smarttab  " make tab insert indents instead of tabs at the start  of linea

" LINE NUMBERS
set number

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Highlight current line
set cursorline
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
"if exists("&relativenumber")
"    set relativenumber
"    au BufReadPost * set relativenumber
"endif
" Start scrolling three lines before the horizontal window border
set scrolloff=1

" Clear last search highlighting
map <Space> :noh<cr>

" Remap escape key to jj
:imap jj <Esc>

" set nowrap
" set showcmd
" set list
" set ttymouse=xterm2
set nobackup
set noswapfile

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" Display tabs and trailing spaces visually
"set list listchars=tab:\ \ ,trail:·

" Evaluate Clojure buffers on load
autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry

" rainbow_parentheses.vim
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces


" autocmd vimenter * NERDTree

set autoindent

" Don't restore old text after closing
set t_ti= t_te=

