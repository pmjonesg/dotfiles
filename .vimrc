" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Get rid of vi compatibility
set nocompatible
" Avoid modelines exploit 

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

" Easy close
map <Leader>q :q!<CR>

" sort block of code
vnoremap <Leader>s :sort<CR>

" easy indenting
vnoremap < <gv
vnoremap > >gv

" Show whitespace
highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%80v', 100)

" Color scheme
set t_Co=256
colorscheme Tomorrow

" Enable syntax highlighting
filetype off
filetype plugin indent on
syntax on

" Showing line numbers and length
set number
" set tw=79
" set nowrap
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

" Close Omni-Completion tip window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd CompleteDone * pclose


" Runtime path setup for Vundle
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" =============================================================================
"  IDE
" =============================================================================

" -----------------------------------------------------------------------------
" Look
" -----------------------------------------------------------------------------
" All the colors!
Plugin 'flazz/vim-colorschemes'
" Powerline
set rtp+=$HOME/.vim/bundle/powerline/powerline/bindings/vim/
Plugin 'powerline/powerline.git'
let g:Powerline_symbols = "fancy"
set laststatus=2
" Custom Statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" Open tags in new tab
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

" -----------------------------------------------------------------------------
" Tmux Integration
" -----------------------------------------------------------------------------
" Proper .tmux.conf editing
Plugin 'tmux-plugins/vim-tmux'
" tmux navigation
Plugin 'christoomey/vim-tmux-navigator'
" Autosave on leave
let g:tmux_navigator_save_on_switch = 1

" -----------------------------------------------------------------------------
" Navigation
" -----------------------------------------------------------------------------
" NERDTree
Plugin 'scrooloose/nerdtree'
" Start NERDTree if no files have been specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Easy access
map <Leader>t :NERDTreeMirror<CR>

" easymotions
Plugin 'easymotion/vim-easymotion'

" -----------------------------------------------------------------------------
" Searching
" -----------------------------------------------------------------------------
" Ctrl-P
Plugin 'kien/ctrlp.vim'
let g:ctrlp_max_height = 40
let g:ctrlp_max_files = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
if exists("g:ctrl_user_command")
      unlet g:ctrlp_user_command
  endif
" set wildignore+=*.pyc,*.java

" -----------------------------------------------------------------------------
" Autocompletion
" -----------------------------------------------------------------------------
" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'
" Use first python executable found in PATH (useful for virtual environments)
let g:ycm_python_binary_path = 'python'
" GoToDeclaration remap
nnoremap <Leader>je :YcmCompleter GoToDeclaration<CR>
" GoToDefinition remap
nnoremap <Leader>jd :YcmCompleter GoToDefinition<CR>
" GetType remap
nnoremap <Leader>jt :YcmCompleter GetType<CR>
" GetDoc remap
nnoremap <Leader>jg :YcmCompleter GetDoc<CR>
" Symbols
let g:ycm_error_symbol = 'EE'
let g:ycm_warning_symbol = 'WW'

" Add snippets path
set runtimepath+=$HOME/.vim/UltiSnips/
" Track the engine
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use 
" https://github.com/Valloric/YouCompleteMe.
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" SuperTab (middle layer as a work-around for tab incompatibility with YCM)
Plugin 'ervandew/supertab'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" path config
let g:UltiSnipsSnippetDir = "~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories = ["~/.vim/UltiSnips"]

" Emmet for easy front-end key bindings
Plugin 'mattn/emmet-vim'

" Surround
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

" -----------------------------------------------------------------------------
" Syntax Checking
" -----------------------------------------------------------------------------
" Syntastic
Plugin 'scrooloose/syntastic'
" disable syntastic on the statusline
let g:statline_syntastic = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
" easy disable (in case performance is a problem)
map <Leader>h :SyntasticToggleMode<CR>

" -----------------------------------------------------------------------------
" Python Specific
" -----------------------------------------------------------------------------
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Style Checker
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Flake8
Plugin 'nvie/vim-flake8'

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Syntax Checker
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
let g:syntastic_python_checkers = ['pyflakes']
" easyTags
" Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-easytags'
" Follow symbolic links
" let g:easytags_resolve_links = 1
" Run asynchronously, don't block vim (ctags runs in the foreground by
" default)
" let g:easytags_async = 1

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Debugging Tools
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Breakpoint macro
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
" Python folding
set nofoldenable
" CVS Integration
" Plugin 'vcscommand.vim'

" -----------------------------------------------------------------------------
" Misc.
" -----------------------------------------------------------------------------
" vimwiki
Plugin 'vimwiki/vimwiki'

" -----------------------------------------------------------------------------
" Javascript Specific
" -----------------------------------------------------------------------------
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Grunt
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Plugin 'thomasvs/grunt.vim'
