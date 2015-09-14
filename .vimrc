set nocp " non-Vi-compatible mode

runtime! plugin/sensible.vim
runtime! plugin/opinion.vim

" Pathogen
try
    runtime bundle/vim-pathogen/autoload/pathogen.vim
    call pathogen#infect()
catch
endtry

" vim-opinion overrides
set nohlsearch " highlight search
set nogdefault
set tabstop=4 " number of spaces which equal <Tab>
set shiftwidth=4 "number of spaces for indent
set swapfile
set scrolloff=1

set cul " cursorline
set smartindent " do smart autoindenting when starting a new line
set foldcolumn=3 " fold column width
set foldlevelstart=2
let xml_syntax_folding=1
let php_folding=1
let javaScript_fold=1
let sh_fold_enabled=1
let vimsyn_folding='af'

map ,v :vsp $MYVIMRC<CR>
" autorefresh .vimrc on change
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

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
silent! colorscheme solarized

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
      \'ledger': 'ledger -s bal ass -reimb'
      \}
for ft_name in keys(ft_stdout_mappings)
    execute 'autocmd Filetype ' . ft_name . ' nnoremap <buffer> <C-\> :write !' . ft_stdout_mappings[ft_name] . '<CR>'
endfor
let ft_execute_mappings = {
      \}
for ft_name in keys(ft_execute_mappings)
    execute 'autocmd Filetype ' . ft_name . ' nnoremap <buffer> <C-\> :write \| !' . ft_execute_mappings[ft_name] . '<CR>'
endfor

let ft_vimpipe_commands = {
    \'php': 'php',
    \'ledger': 'ledger -s bal ass -reimb'
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

let g:phpqa_messdetector_autorun = 0
let g:phpqa_codesniffer_autorun = 0
let g:phpqa_codecoverage_autorun = 0

" vimwiki
let wiki_1 = {}
let wiki_1.path = '~/Dropbox/_data/vimwiki/'
let g:vimwiki_list = [wiki_1]

" vim-ledger
let g:ledger_detailed_first = 1
let g:ledger_fillstring = '_'
let g:ledger_fold_blanks = 1
nnoremap <silent> <Leader>c :call ledger#transaction_state_toggle(line('.'), ' *?!')<CR>
nnoremap <silent> <Leader>d :call ledger#transaction_date_set(line('.'), "primary")<CR>

" vim-go
autocmd FileType go nmap <C-\> :GoRun %<Enter>
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
