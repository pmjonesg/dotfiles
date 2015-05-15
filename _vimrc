"
" Vim configuration for Windows
" Author: Peter Jones
" Latest modification: 2015-05-10
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Index
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I.   Plugins
" II.  Functionality
" III. Misc
"

set nocompatible              " be iMproved, required
filetype off                  " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I. Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List of plugins:
" - Vundle
" - NERDtree
" - CTRL-P
" - Syntastic
" - Surround
" - delimitMate
" - vim-repeat
" - colorschemes
" - vim-indent-guides
" - vim-airline
"

" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim/
let path='~/vimfiles/bundle'
call vundle#begin(path)
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" IDE features
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
" syntax and language completion
Plugin 'scrooloose/syntastic'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-repeat'
" look and feel
Plugin 'flazz/vim-colorschemes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'bling/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" II. Functionality
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set nu

" Highlight all characters past column 80
augroup vimrc_autocmds
    autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
    autocmd BufEnter * match OverLength /\%80v.*/
augroup END

" Size of hard tabstop
set tabstop=4
" Size of an indent
set shiftwidth=4
" Size of soft tabstop
set softtabstop=4
" Make tab insert indents instead of tabs at the beginning of a line
set smarttab
" Use spaces instead of tab characters
set expandtab
set backspace=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" III. Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme default
set laststatus=2
set showcmd


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IV. Plugin-specific
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use identation by default of 2 spaces on every instance of vim, use
" <Leader>ig to disable
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

