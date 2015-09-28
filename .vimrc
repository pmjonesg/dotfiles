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
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
set t_Co=256
colorscheme Tomorrow

" Enable syntax highlighting
filetype off
filetype plugin indent on
syntax on

" Showing line numbers and length
set number
set tw=79
set nowrap
set fo-=t
set colorcolumn=80
highlight ColorColumn ctermbg=233

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

" Runtime path setup for Vundle
set rtp+=~/.vim/bundle/vundle
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
" Autosave on leave
let g:tmux_navigator_save_on_switch = 1

Plugin 'crusoexia/vim-monokai'
" Powerline
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim/
Plugin 'powerline/powerline.git'
let g:Powerline_symbols = "fancy"
set laststatus=2
" Ctrl-P
Plugin 'kien/ctrlp.vim'
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" python-mode
Plugin 'klen/python-mode'
map <Leader>g :call RopeGotoDefinition()<CR>
let g:pymode_folding = 1
let g:pymode_run = 1
let g:pymode_run_bind = '<Leader>r'
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_definition_cmd = "new"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigation through omnicomplete option list
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Python folding
set nofoldenable
