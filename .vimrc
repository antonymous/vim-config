set nocp " non-Vi-compatible mode

" edit .vimrc on <,><v>
map ,v :vsp $MYVIMRC<CR>
" autorefresh .vimrc on change
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin indent on

syntax enable

set cul " cursorline
set ruler " show cursor position
set showcmd " show command as we type
set nohlsearch " highlight search
set incsearch " incremental search
set ignorecase " ignore case while searching
set smartcase " don't ignore case for UPPERCASE search terms?
set number " show line numbers
set foldcolumn=5 " fold column width
set nowrap " don't wrap long lines
set encoding=utf-8 " Vim's internal encoding
set backspace=indent,eol,start

set iskeyword=@,48-57,_,192-255

set tabstop=4 " number of spaces which equal <Tab>
set shiftwidth=4 "number of spaces for indent
set smarttab " use 'shiftwidth' at the start of the line instead 'tabstop'
" set expandtab " use spaces instead of tab
set smartindent " do smart autoindenting when starting a new line

set wildmenu " show command complition menu
set wildmode=list:longest,full

set scrolloff=3 " begin scrolling N lines earlier

set keymap=russian-jcukenwin " keyboard mapping switched with Ctrl+^
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

" map ё `
" map й q
" map ц w
" map у e
" map к r
" map е t
" map н y
" map г u
" map ш i
" map щ o
" map з p
" map х [
" map ъ ]
 
" map ф a
" map ы s
" map в d
" map а f
" map п g
" map р h
" map о j
" map л k
" map д l
" map ж ;
" map э '
 
" map я z
" map ч x
" map с c
" map м v
" map и b
" map т n
" map ь m
" map б ,
" map ю .
 
" map Ё ~
" map Й Q
" map Ц W
" map У E
" map К R
" map Е T
" map Н Y
" map Г U
" map Ш I
" map Щ O
" map З P
" map Х {
" map Ъ }

" map Ф A
" map Ы S
" map В D
" map А F
" map П G
" map Р H
" map О J
" map Л K
" map Д L
" map Ж :
" map Э "
" map Я Z

" map Ч X
" map С C
" map М V
" map И B
" map Т N
" map Ь M
" map Б <
" map Ю >
 
 
if has('win32')	
	" autoformat XML with HTML Tidy 
	au FileType xml exe ":silent 1,$!tidy -q -i -xml"

	" select xml text to format and hit ,x
	vmap ,x :!tidy -q -i -xml<CR>
endif

" Font settings for GUI
if has('gui_running')
	if has('win32')
		set guifont=consolas:h10:cRUSSIAN
	elseif has('gui_gtk2')
		set guifont=Consolas\ 11
	endif
endif

" Solarized theme
if has('gui_running')
    set background=light
	colorscheme solarized
else
	set t_Co=16
	set background=dark
	colorscheme solarized
endif

nnoremap <silent> ,l :w <BAR> !lessc % > %:t:r.css<CR><space>
nnoremap <silent> ,r :exec &nu==&rnu? 'se nu!' : 'se rnu!'<CR>
nnoremap <silent> ,w :set wrap!<CR>

" syntastic
let g:syntastic_check_on_open=1
let g:syntastic_auto_jump=1
