"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------
set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dracula/vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-autoclose'
Plugin 'tpope/vim-surround'
call vundle#end()

filetype plugin indent on

" nerdcommenter
let mapleader = ","
let g:NERDSpaceDelims = 1

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

"-------------------------------------------------------------------------------
" Customization
"-------------------------------------------------------------------------------
" Set theme
colorscheme dracula

" Set font
set guifont=Inconsolata-dz\ for\ Powerline

" Set highlighted column for 80 column width
let &colorcolumn=80

" Set shortcuts for buffer controls
nnoremap <F2> :bprevious<CR>
nnoremap <F3> :bnext<CR>
nnoremap <F4> :set number!<CR>

" Set shortcuts for window controls
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Set syntax highlighting 
syntax on

" Set indenting (default: spaces, 4)
set tabstop=4 shiftwidth=4 expandtab autoindent smartindent
autocmd FileType html setlocal tabstop=2 shiftwidth=2

" Disable word wrapping
set nowrap

" Use smart case in search
set ignorecase smartcase

" Show tab line always
set showtabline=2

" Show status bar always
set laststatus=2

" Enable mouse
set mouse=a

" Hide unsaved buffers when opening new ones
set hidden

