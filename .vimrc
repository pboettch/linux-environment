" Configuration file for vim

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start	" more powerful backspacing

set formatoptions+=roc

set textwidth=0     " Don't wrap words by default
set nobackup        " Don't keep a backup file

set viminfo='20,\"50	" read/write a .viminfo file, don't store more than
		" 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
set t_Co=16
set t_Sf=[3%dm
set t_Sb=[4%dm
endif

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on
set hlsearch

" Debian uses compressed helpfiles. We must inform vim that the main
" helpfiles is compressed. Other helpfiles are stated in the tags-file.
set helpfile=$VIMRUNTIME/doc/help.txt.gz

set wildmode=longest:full
set wildmenu

" Some Debian-specific things
augroup filetype
au BufRead reportbug.*		set ft=mail
au BufRead reportbug-*		set ft=mail
au BufRead *.sql            set ft=mysql
au BufRead *.tpl            set ft=smarty
au BufRead *.red            set ft=redcode
augroup END

"let redcode_88_only = 1
"let redcode_94_only = 1
let redcode_highlight_numbers=1



" The following are commented out as they cause vim to behave a lot
" different from regular vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make

" Removes trailing spaces
function TrimWhiteSpace()
: %s/\s*$//
: ''
:endfunction

"set list listchars=trail:.,extends:>
autocmd FileWritePre   * :call TrimWhiteSpace()
autocmd FileAppendPre  * :call TrimWhiteSpace()
autocmd FilterWritePre * :call TrimWhiteSpace()
autocmd BufWritePre    * :call TrimWhiteSpace()

map  <F3>  :call TrimWhiteSpace()<CR>
map! <F3>  :call TrimWhiteSpace()<CR>


" Now we set some defaults for the editor
set noautoindent      " always set autoindenting on
set nosmartindent     "
set shiftwidth=4
set smarttab

set noexpandtab
set ts=4
map <F2> :w<CR>
map <C-J> :set textwidth=70<CR><ESC>gqap:set textwidth=0<CR>
map! <C-J> <ESC>gqapi
set nowrap

"set nocindent
set cinwords=if,else,while,do,for,switch,case
set cinoptions=:0,g0,l1
set cindent

map <C-T>     :tabnew<CR>
map <s-Left>  :tabprev<CR>
map <s-Right> :tabnext<CR>
imap <s-Left>  <ESC>:tabprev<CR>i<Right>
imap <s-Right> <ESC>:tabnext<CR>i<Right>

noremap <silent> <C-s-Left>  :exe "silent! tabmove " . (tabpagenr() - 2)<CR>
noremap <silent> <C-s-Right> :exe "silent! tabmove " . tabpagenr()<CR>

" error/quickfix
let &errorformat="%f:%l: %t%*[^:]:%m," . &errorformat
let &errorformat="%f:%l:%c: %t%*[^:]:%m," . &errorformat
let errormarker_warningtypes = "wW"
map <F5> :tabfirst<CR>:make<CR>:cw<CR>
map <F6> :cp<CR>
map <F7> :cn<CR>

map tk :set shiftwidth=4 ts=4 noet<CR>

map tn :tabnew<SPACE>

let c_space_errors=1

set background=light

" hi Comment   term=bold   ctermfg=DarkGrey    guifg=DarkGrey

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif
endif " has("autocmd")


func GitGrep(...)
   let save = &grepprg
   set grepprg=git\ grep\ -n\ $*
   let s = 'grep'
   for i in a:000
       let s = s . ' ' . i
   endfor
   exe s
   let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

func GitGrepWord()
  normal! "zyiw
  call GitGrep('-w -e ', getreg('z'))
endf
"nmap <C-x>G :call GitGrepWord()<CR>

" grep
map <F4> :call GitGrepWord()<Bar> cw<CR>

" remove Print-button
:aunmenu ToolBar.Print
