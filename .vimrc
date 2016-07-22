set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
"Plugin 'valloric/youcompleteme'

call vundle#end()            " required
filetype plugin indent on    " required
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

let g:syntastic_perl_checkers = ['podchecker']
"let g:syntastic_perl_checkers = ['perl', 'podchecker']
"let g:syntastic_enable_perl_checker = 1

"autocmd vimenter * NERDTree		" open directory tree in vim

set showtabline=2	" always show tab bar

"set nowrap
set number			" show line numbers

"Indenting
set autoindent		" some magic
"set expandtab		" don't use tab character
set shiftwidth=4 	" sets indent width when you use >
set smartindent		" some magic
set tabstop=4		" displayed width of tab

set mouse=a			" enable mouse

set ignorecase		" ignores case in search
set smartcase		" case sensitive if searched word is capitalized
"set incsearch		" show next match to search input

"nmap <CR>	o<Esc>

"inoremap ( ()<Esc>i
"inoremap { {<CR>}<Esc>ko
"inoremap [ []<Esc>i
