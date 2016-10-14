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
" let g:syntastic_perl_checkers = ['perlcritic', 'podchecker']
" let g:syntastic_enable_javascript_checker = 1
" let g:syntastic_enable_perl_checker = 1

" tagbar
let g:tagbar_ctags_bin = "/usr/bin/ctags"
nmap <F8> :TagbarToggle<CR>

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

"-------------------------------------------------------------------------------
" Perforce
"-------------------------------------------------------------------------------
function! PerforceAdd()
    call inputsave()
    let answer = input('Add file? (y/n) ')
    call inputrestore()
    if answer == "y"
        call system("p4 add " . expand("%"))
    endif
endfunction

function! PerforceEdit()
    call inputsave()
    let answer = input('Edit file? (y/n) ')
    call inputrestore()
    if answer == "y"
        call system("p4 edit " . expand("%"))
        w!
    endif
endfunction

function! PerforceRevert()
    call inputsave()
    let answer = input('Revert file? (y/n) ')
    call inputrestore()
    if answer == "y"
        call system("p4 revert " . expand("%"))
        e!
    endif
endfunction

noremap <C-a>a :call PerforceAdd()<CR>
noremap <C-a>e :call PerforceEdit()<CR>
noremap <C-a>r :call PerforceRevert()<CR>

"-------------------------------------------------------------------------------
" Customization
"-------------------------------------------------------------------------------
" Set highlighted column for 80 column width
highlight ColorColumn ctermbg=235
let &colorcolumn=80

" Set shortcuts for buffer controls
nnoremap <F2> :bprevious<CR>
nnoremap <F3> :bnext<CR>
nnoremap <F4> :buffers<CR>:buffer<Space>

" Set shortcuts for window controls
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Set syntax highlighting 
syntax on
au BufRead,BufNewFile *.esp setfiletype perl
au BufRead,BufNewFile *.less setfiletype css
au BufRead,BufNewFile *.whiskers setfiletype html

" Set indenting (default: tabs, 4)
set tabstop=4 shiftwidth=4
autocmd FileType ruby setlocal expandtab tabstop=2 shiftwidth=2

" Indent lines automatically
set autoindent smartindent

" Use smart case in search
set ignorecase smartcase

" Open new panes to the right and bottom
set splitbelow splitright

" Show line numbers
set number

" Show tab line always
set showtabline=2

" Show status bar always
set laststatus=2

" Hide unsaved buffers when opening new ones
set hidden

" Enable mouse
set mouse=a
