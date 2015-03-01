set nocp " non-Vi-compatible mode

map ,v :vsp $MYVIMRC<CR>
" autorefresh .vimrc on change
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Pathogen
try
    runtime bundle/vim-pathogen/autoload/pathogen.vim
    call pathogen#infect()
catch
endtry

filetype plugin indent on

set encoding=utf-8 " Vim's internal encoding
set cul " cursorline
set ruler " show cursor position
set showcmd " show command as we type
set nohlsearch " highlight search
set incsearch " incremental search
set ignorecase " ignore case while searching
set smartcase " but don't ignore case for UPPERCASE instances
set number " show line numbers
set nowrap " don't wrap long lines
set backspace=indent,eol,start
set scrolloff=1 " begin scrolling N lines earlier


if exists('&relativenumber')
    set relativenumber

    :au FocusGained * :set relativenumber
    :au FocusLost * :set norelativenumber

    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber

    " https://github.com/jeffkreeftmeijer/vim-numbertoggle
    function! NumberToggle()
        if(&relativenumber == 1)
            set norelativenumber
        else
            set relativenumber
        endif
    endfunc

    nnoremap <silent> <Leader>n :call NumberToggle()<cr>
endif

syntax enable
set foldmethod=syntax
set foldcolumn=3 " fold column width
set foldlevelstart=2
set foldnestmax=2
let xml_syntax_folding=1
let php_folding=1
let javaScript_fold=1
let sh_fold_enabled=1
let vimsyn_folding='af'

set tabstop=4 " number of spaces which equal <Tab>
set shiftwidth=4 "number of spaces for indent
set smarttab " use 'shiftwidth' at the start of the line instead 'tabstop'
set expandtab " use spaces instead of tab
set smartindent " do smart autoindenting when starting a new line

set wildmenu " show command completion menu
set wildmode=list:longest,full

set keymap=russian-jcukenwin " keyboard mapping switched with Ctrl+^
set iskeyword=@,48-57,_,192-255 " adds cyrillics to keywords
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

set listchars=eol:$,tab:│→,trail:·

" emacs-keys
:cnoremap <C-A>		<Home>
:cnoremap <C-B>		<Left>
:cnoremap <C-D>		<Del>
:cnoremap <C-E>		<End>
:cnoremap <C-F>		<Right>
:cnoremap <C-N>		<Down>
:cnoremap <C-P>		<Up>
:cnoremap <Esc><C-B>	<S-Left>
:cnoremap <Esc><C-F>	<S-Right>

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
        " set guifont=Powerline\ Consolas\ 11
        set guifont=Terminus\ 15
	endif
endif

set background=dark
if exists("g:solarized_termcolors")
    colorscheme solarized
endif

nnoremap <silent> ,l :w <BAR> !lessc % > %:t:r.css<CR><space>
"nnoremap <silent> ,r :exec &nu==&rnu? 'se nu!' : 'se rnu!'<CR>
"nnoremap <silent> ,r :exec &nu==1 ? 'se nu!' : 'se rnu!'<CR>
nnoremap <silent> ,o o<ESC>
nnoremap <silent> ,O O<ESC>
nnoremap <silent> <Leader>l :set list!<CR>
nnoremap <silent> <Leader>w :set wrap!<CR>

" Allow saving of files as sudo
cmap w!! %!sudo tee > /dev/null %

" syntastic
let g:syntastic_check_on_open=0
let g:syntastic_auto_jump=1
map <Leader>s :SyntasticToggleMode<CR>
map <silent> <Leader>e :Errors<CR>

" vim-airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0

" Signify
let g:signify_vcs_list=['git']

" delimitMate
let g:delimitMate_offByDefault=1

" run current buffer based on file type (http://www.oinksoft.com/blog/view/6/)
let ft_stdout_mappings = {
      \'applescript': 'osascript',
      \'bash': 'bash',
      \'bc': 'bc',
      \'haskell': 'runghc',
      \'javascript': 'node',
      \'lisp': 'sbcl',
      \'nodejs': 'node',
      \'ocaml': 'ocaml',
      \'perl': 'perl',
      \'php': 'php',
      \'python': 'python',
      \'ruby': 'ruby',
      \'scheme': 'scheme',
      \'sh': 'sh',
      \'sml': 'sml',
      \'spice': 'ngspice',
      \'ledger': 'ledger -f $LEDGER_FILE -s bal ass -reimb'
      \}
for ft_name in keys(ft_stdout_mappings)
    execute 'autocmd Filetype ' . ft_name . ' nnoremap <buffer> <C-\> :write !' . ft_stdout_mappings[ft_name] . '<CR>'
endfor

let ft_vimpipe_commands = {
    \'php': 'php',
    \'ledger': 'ledger -f $LEDGER_FILE -s bal ass -reimb'
    \}
for ft_name in keys(ft_vimpipe_commands)
    execute 'autocmd FileType ' . ft_name . ' let b:vimpipe_command="' . ft_vimpipe_commands[ft_name] . '"'
endfor

" always use clipboard for "+ register
if has('unnamedplus')
    set clipboard=unnamedplus
endif

" insert current date
nnoremap <F5> "=strftime("%Y-%m-%d")<CR>
inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>
iab <expr> curdate strftime("%Y-%m-%d")

" stronger encryption algo
if has('blowfish')
    set cm=blowfish
endif

let g:phpqa_messdetector_autorun = 0
let g:phpqa_codesniffer_autorun = 0
let g:phpqa_codecoverage_autorun = 0

" incsearch.vim
let g:incsearch#auto_nohlsearch = 1
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" vimwiki
let wiki_1 = {}
let wiki_1.path = '~/Dropbox/_data/vimwiki/'
let g:vimwiki_list = [wiki_1]
