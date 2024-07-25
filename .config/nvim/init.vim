" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction


" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure'}

" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" For Telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

""""""""""""""

Plug 'leafgarland/typescript-vim'

Plug 'kien/rainbow_parentheses.vim'

Plug 'ratazzi/blackboard.vim'

Plug 'guns/vim-clojure-highlight'

Plug 'guns/vim-clojure-static'

Plug 'vim-scripts/paredit.vim'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'airblade/vim-gitgutter'

Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }

"Plug 'tpope/vim-fireplace', { 'for': 'clojure', 'on': 'FireplaceConnect' }

"Plug 'clojure-vim/vim-cider'

"Plug 'junegunn/vim-easy-align'

Plug 'avakhov/vim-yaml'

Plug 'scrooloose/nerdtree'

Plug 'hashivim/vim-terraform'

Plug 'scrooloose/nerdcommenter'

Plug 'christoomey/vim-tmux-navigator'

Plug 'weirongxu/plantuml-previewer.vim'

Plug 'tyru/open-browser.vim'

Plug 'aklt/plantuml-syntax'

Plug 'github/copilot.vim'

"Initialize plugin system
call plug#end()


" start with insert mode
let g:unite_enable_start_insert = 1

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let clj_param_rainbow = 1

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

let mapleader = '\<Space>'
let maplocalleader = '\<Space>'

" remap NERDComToggleComment
map <leader>/ <leader>c<Space>

" COLOR SCHEMES:
set background=dark

" colorscheme desert-warm-256
colorscheme blackboard
" colorscheme solarized

if &t_Co > 2 || has("gui_running")
  " Enable syntax highlighting
  syntax on
endif

" Stop GitGutter from appears and disappearing
set signcolumn=yes
highlight SignColumn guibg=black ctermbg=black
highlight GitGutterAdd guifg=green ctermfg=green
highlight GitGutterDelete guifg=red ctermfg=red
highlight GitGutterChange guifg=yellow ctermfg=yellow

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

"set tabstop=4 " The width of a TAB is set to 4.
              "" Still it is a \t. It is just that
              "" Vim will interpret it to be having
              "" a width of 4.
"set softtabstop=0 " Sets the number of columns for a TAB
"set expandtab " Indents will have a width of 4
"set shiftwidth=4 " Indents will have a width of 4
"set smarttab  " make tab insert indents instead of tabs at the start  of line

set expandtab
set shiftwidth=2
set softtabstop=2

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Highlight current line
" set cursorline "This might be slowing down my scrolling

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
:set number
":augroup numbertoggle
":  autocmd!
":  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
":  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
":augroup END

" LINE NUMBERS
:highlight LineNr ctermfg=grey

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

" Display tabs and trailing spaces visually
"set list listchars=tab:\ \ ,trail:·

" Evaluate Clojure buffers on load
autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry

" autocmd vimenter * NERDTree

set autoindent

" Don't restore old text after closing
set t_ti= t_te=

let clj_highlight_builtins = 1


" yank and paste using y and p from Vim
set clipboard=unnamed

" Airline
let g:airline_theme='simple'

" Cljfmt
let g:clj_fmt_autosave = 1
nmap <Leader>ff <Plug>CljFmt
nmap <Leader>fr :'a,'b CljfmtRange<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set foldlevel=99

autocmd vimenter * NERDTree

let NERDTreeShowHidden=1

" Remap vim split navigation to use Ctrl hjkl

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Speed up scrolling
set lazyredraw
set regexpengine=1
set ttyfast " u got a fast terminal
"set ttyscroll=3

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=128

" Stop vim from adding or subtracting a newline at end of files.
set binary
set noeol

" Terraform
let g:terraform_fmt_on_save=1
let g:terraform_align=1

" Highlight all tabs
function! HiTabs()
    syntax match TAB /\t/
    hi TAB ctermbg=blue ctermfg=red
endfunction
au BufEnter,BufRead * call HiTabs()


" TypeScript settings
autocmd FileType typescript setlocal shiftwidth=4 softtabstop=4 expandtab

" Make it so that I can navigate big files that are a single line
nnoremap j gj
nnoremap k gk
" Scroll down
"noremap <silent> <ScrollWheelDown> gj
"noremap <silent> <C-ScrollWheelDown> 3gj
" Scroll up
"noremap <silent> <ScrollWheelUp> gk
"noremap <silent> <C-ScrollWheelUp> 3gk

