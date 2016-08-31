set nocompatible
set hidden
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
"Plugin 'bling/vim-bufferline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'majutsushi/tagbar'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'townk/vim-autoclose'
call vundle#end()

filetype plugin indent on

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_enable_javascript_checker = 1

"let g:syntastic_perl_checkers = ['perlcritic', 'podchecker']
"let g:syntastic_enable_perl_checker = 1

" tagbar
let g:tagbar_ctags_bin = "/usr/bin/ctags"

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

" Show status bar always
set laststatus=2

" Show line numbers
set number

" Use indenting
set autoindent
set smartindent

" Use spaces instead of tab
"set expandtab

" Set tab width to 4 spaces
set tabstop=4
set shiftwidth=4

" Enable mouse
set mouse=a

" Use smart case in search
set ignorecase
set smartcase

" Open new panes to right and bottom
set splitbelow
set splitright

" Key mapping
nmap <F8> :TagbarToggle<CR>

nnoremap <F2> :bprevious<CR>
nnoremap <F3> :bnext<CR>
nnoremap <F4> :buffers<CR>:buffer<Space>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"inoremap <C-a> `

autocmd BufReadPost *.whiskers set syntax=html
autocmd BufReadPost *.less set syntax=css
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 expandtab
