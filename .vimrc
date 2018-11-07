" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy & paste
set pastetoggle=<F2>
set clipboard=unnamed
" Mouse and backspace
set mouse=a
set bs=2

" Rebind <Leader> key
let mapleader = ","

" Bind nohl
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Window movement
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

" Tab movement
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>
map <Leader>tn <esc>:tabnew<CR>
map <Leader>tc <esc>:tabclose<CR>

" sort block of code
vnoremap <Leader>s :sort<CR>

" easy indenting
vnoremap < <gv
vnoremap > >gv

" Show whitespace
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
set t_Co=256

" Highlight color
set hlsearch
hi Search ctermbg=White
set lcs+=space:·

" Enable syntax highlighting
filetype off
filetype plugin indent on

" Showing line numbers and length
set number
set relativenumber
set tw=120
set nowrap
" set fo-=t
" set colorcolumn=80
" highlight ColorColumn ctermbg=233

" easy formatting for paragraphs
vmap Q gq
nmap Q gqap

" History
set history=1000
set undolevels=1000

" No tabs please
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Case insensitive searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Set folds
set foldmethod=indent

" No swp files
set noswapfile

" statusline to display line and column
set statusline=%F\ %l\:%c

" close buffer, not tab
nmap <Leader>q :bd<CR>

" debug statements
nmap <Leader>d O# DEBUG<ESC>
nmap <Leader>D o# ENDDEBUG<ESC>

" Runtime path setup for Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" =============================================================================
"  Python IDE
" =============================================================================
" All the colors!
Plugin 'flazz/vim-colorschemes'
" Proper .tmux.conf editing
Plugin 'tmux-plugins/vim-tmux'
" tmux navigation
Plugin 'christoomey/vim-tmux-navigator'
" vimwiki
Plugin 'vimwiki/vimwiki'

" Autosave on leave
let g:tmux_navigator_save_on_switch = 1

" Powerline
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim/
Plugin 'powerline/powerline.git'
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = "unicode"
set laststatus=2

" Syntastic
Plugin 'vim-syntastic/syntastic'

" Ctrl-P
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 40
let g:ctrlp_max_files = 0
let g:ctrlp_follow_symlinks = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
if exists("g:ctrl_user_command")
    unlet g:ctrlp_user_command
endif

" YouCompleteMe
" Plugin 'Valloric/YouCompleteMe'
" let g:ycm_collect_identifiers_from_tags_files = 0
"
" Autocompletion
" Plugin 'shougo/deoplete.nvim'
" Plugin 'davidhalter/jedi-vim'
" Plugin 'zchee/deoplete-jedi'
Plugin 'Valloric/YouCompleteMe'

" Flake8
Plugin 'nvie/vim-flake8'
" call flake8#Flake8UnplaceMarkers()
autocmd BufWritePost *.py call Flake8()
let g:flake8_show_quickfix=1
let g:flake8_show_in_file=1
let g:flake8_error_marker='EE'
let g:flake8_warning_marker='WW'

" Scratch buffer
Plugin 'mtth/scratch.vim'

Plugin 'majutsushi/tagbar'
nmap <Leader>b :TagbarToggle<CR>
nnoremap <Leader>c :CtrlPTag<CR>

" Tag maps
nmap <Leader>l :ts<CR>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Open tags in new tab
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

" The godsend
Plugin 'vim-scripts/EasyGrep'

" Nice diffs
Plugin 'chrisbra/vim-diff-enhanced'

" Source Tree
Plugin 'scrooloose/nerdtree'
" Default to NERDTree when opening a dir
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Easy bind
map <C-n> :NERDTreeToggle<CR>
" Close if only NERDTree open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Stack of yanks
Plugin 'maxbrunsfeld/vim-yankstack'
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Snippets
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
set rtp+=~/.vim/UltiSnips/
Plugin 'honza/vim-snippets'
" Python 3
let g:UltiSnipsUsePythonVersion = 3
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Debugging
map <Leader>db Oimport ipdb; ipdb.set_trace()<ESC>

" Python folding
set nofoldenable

" Modern selection
Plugin 'terryma/vim-expand-region'

" Docker support
Plugin 'ekalinin/Dockerfile.vim'


" =============================================================================
"  Note Taking
" =============================================================================
Plugin 'jceb/vim-orgmode'
