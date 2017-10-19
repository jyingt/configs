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
" Plugin 'edkolev/tmuxline.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'townk/vim-autoclose'
Plugin 'tpope/vim-surround'
call vundle#end()

filetype plugin indent on

" nerdcommenter
let mapleader = ","
let g:NERDSpaceDelims = 1 " 

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

"-------------------------------------------------------------------------------
" Functions
"-------------------------------------------------------------------------------
function! PerforceAdd()
	call inputsave()
	let l:answer = input('Add file? (y/n) ')
	call inputrestore()
	if l:answer == "y"
		call system("p4 add " . expand("%"))
	endif
endfunction

function! PerforceEdit()
	call inputsave()
	let l:answer = input('Edit file? (y/n) ')
	call inputrestore()
	if l:answer == "y"
		call system("p4 edit " . expand("%"))
		w!
	endif
endfunction

function! PerforceRevert()
	call inputsave()
	let l:answer = input('Revert file? (y/n) ')
	call inputrestore()
	if l:answer == "y"
		call system("p4 revert " . expand("%"))
		e!
	endif
endfunction

function! OpenAthenaFile()
	let l:line = getline(".")

	let l:path = ''
	let l:sub = ''

	if &filetype == "perl"
		let l:module = matchstr(l:line, "\\([A-Za-z]\\+::\\)\\+[A-Za-z]\\+(")

		" Extract subroutine and module names if possible
		if !empty(l:module)
			let l:sub = matchstr(l:module, "[A-Za-z]\\+(")
			let l:sub = matchstr(l:sub, "[A-Za-z]\\+")

			let l:module = matchstr(l:module, "\\([A-Za-z]\\+::\\)\\+")
			let l:module = matchstr(l:module, "\\([A-Za-z]\\+::\\)*[A-Za-z]\\+")
		else
			" Otherwise, extract just module name
			let l:module = matchstr(l:line, "\\([A-Za-z]\\+::\\)\\+[A-Za-z]\\+")
		endif

		" Extract module name in other ways if module name is not found yet
		if empty(l:module)
			if !empty(matchstr(l:line, "package\\|use [\\(\\):A-Za-z]\\+ \\|;"))
				let l:linesplit = split(l:line)
				let l:module = matchstr(l:linesplit[1], "[:A-Za-z]\\+")
			endif
		endif

		" Handle format: $self->Persistence('LabResult')->GetLabResults();

		if !empty(l:module)
			let l:path = ParseAthenaPerlFilePath(l:module)
		endif
	else
		let l:module = matchstr(l:line, "[A-Za-z]\\+:[-./0-9A-Z_a-z]\\+")

		if !empty(l:module)
			let l:path = ParseAthenaStaticFilePath(l:module)
		endif

		" TODO: open data view class from whiskers
		if &filetype == "html"
			if l:line =~ "data-view-classes"
				let l:linesplit = split(l:line, "=")
				let l:viewclass = matchstr(l:linesplit[1], "[-a-z]\\+")
				let l:path = l:viewclass
			elseif l:line =~ "view_classes"
				let l:linesplit = split(l:line, ":")
				let l:viewclass = matchstr(l:linesplit[1], "[-a-z]\\+")
				let l:path = l:viewclass
			endif
		endif

		" TODO: style sheet class matching
	endif

	" Open file if path exists
	if filereadable(l:path)
		execute "edit " . l:path

		" Search for subroutine
		if !empty(l:sub)
			execute "normal! /\\<sub " . l:sub . "\\>\<cr>"
		endif
	else
		let l:error =  "Cannot open file!"

		if !empty(l:path)
			let l:error = l:error . " (" . l:path . ")"
		endif

		echom l:error
	endif
endfunction

function! ParseAthenaStaticFilePath(module)
	let l:modulesplit = split(a:module, ":")
	let l:product = l:modulesplit[0]
	let l:path = l:modulesplit[1]

	if l:product =~ "shared"
		let l:path = expand("$ATHENA_HOME/htdocs/static/shared") . l:path
	else
		if l:product =~ "product"
			" Read product from current file's full path
			let l:currentpath = expand('%:p:h')
			let l:currentpathcomponents = split(l:currentpath, '/')
			let l:productindex = index(l:currentpathcomponents, 'release') + 1
			let l:product = l:currentpathcomponents[l:productindex]
		endif

		let l:path = expand("$AX_HOME/") . l:product . "/web/htdocs/static" . l:path
	endif

	if l:path =~ "/templates/"
		let l:path = l:path . ".whiskers"
	elseif l:path !~ "\\.[a-z]\\+$"
		let l:path = l:path . ".js"
	endif

	return l:path
endfunction

function! ParseAthenaPerlFilePath(namespace)
	let l:path = substitute(a:namespace, "::", "/", "g")

	if a:namespace =~ "AthenaX::Airlock"
		let l:path = expand("$AX_HOME/airlock/perl/lib/") . l:path
	elseif a:namespace =~ "AthenaX::Clinical"
		let l:path = expand("$AX_HOME/clinical/perl/lib/") . l:path
	elseif a:namespace =~ "AthenaX::Inpatient"
		let l:path = expand("$AX_HOME/inpatient/perl/lib/") . l:path
	elseif a:namespace =~ "AthenaX"
		let l:path = expand("$AX_HOME/base/perl/lib/") . l:path
	else
		let l:path = expand("$ATHENA_HOME/perllib/Athena/") . l:path

		" if !filereadable(l:path)
			" let l:path = expand("$INTRANET_HOME/perllib/Athena/") . l:path
		" end
	endif

	return l:path . ".pm"
endfunction

noremap <C-a>a :call PerforceAdd()<CR>
noremap <C-a>e :call PerforceEdit()<CR>
noremap <C-a>r :call PerforceRevert()<CR>
noremap <C-a>g :call OpenAthenaFile()<CR>

"-------------------------------------------------------------------------------
" Customization
"-------------------------------------------------------------------------------
" Set theme
colorscheme dracula

" Set highlighted column for 80 column width
let &colorcolumn=80

" Set shortcut for tagbar
nnoremap <F8> :TagbarToggle<CR>

" Set shortcuts for buffer controls
nnoremap <F2> :bprevious<CR>
nnoremap <F3> :bnext<CR>
" nnoremap <F4> :buffers<CR>:buffer<Space>

" Set shortcut for line numbers
nnoremap <F4> :set number!<CR>

" Set shortcuts for window controls
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Set syntax highlighting 
syntax on
autocmd BufRead,BufNewFile *.esp setfiletype perl
autocmd BufRead,BufNewFile *.less setfiletype css
autocmd BufRead,BufNewFile *.whiskers setfiletype html

" Set indenting
autocmd FileType javascript setlocal tabstop=4 shiftwidth=4
autocmd FileType perl setlocal tabstop=4 shiftwidth=4
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 expandtab 
autocmd FileType *.yaml setlocal tabstop=2 shiftwidth=2 expandtab 
autocmd FileType *.worker.config setlocal tabstop=2 shiftwidth=2 expandtab 

" Disable word wrapping
set nowrap

" Indent lines automatically
set autoindent smartindent

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

