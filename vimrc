"This is my vim Customisation file.
" NOTE: Function keys
"       <F1> - Help (as usual for vim)
"       <F2> -
"       <F3> - Ultisnips list completions
"       <F4> -
"       <F5> - GundoToggle
"       <F6> - TlistToggle
"       <F7> - NERDTreeToggle
"       <F8> - switch through colours
"       <F9> - Remove trailing whitespace
"       <F10> -
"       <F11> - (in C/C++) cscope update
"       <F12> - ctags update


set nocompatible

" Pathogen plugin {{{
execute pathogen#infect()
call pathogen#helptags()
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Manage spaces and tabs {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"stay indented when getting new line
set autoindent
set shiftwidth=4

"make a tab change to 4 spaces
set expandtab
set tabstop=4
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Errorbells {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Don't keep bugging me whenever I type something wrong
set noerrorbells
"set novisualbells
set t_vb=
set tm=500
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Changing the look of the editor {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Add a foldcolumn
set foldcolumn=2
"set the characters seperating multiple vim windows to blank space
set fillchars=vert:\ 
"can use set fillchars+=diff:\\ to make deleted lines in diffmode
"have the '\' character along them instead of the '-' character

" Always show filename
set ls=2

"Highlights all occurances of the last search pattern
" but let Space in command mode turn off the highlighting
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
"I have no idea what the <Bar> part of this means

"get vim to automatically highlight based on syntax and file extension
syntax on
filetype on
" cursorline/column
set cursorcolumn
set cursorline
color techras
"if in the tty only have 8 colours - tell vim that
if &term == "linux" || &term == "screen"
    set t_Co=8
"if in xterm in X, have 256 colours, use them all
elseif &term == "xterm-256color" || &term == "xterm" || &term == "screen-256color"
    "This has to be set after the set syntax, as it is overwitten otherwise
    set t_Co=256
    "Make the cursor in command mode be a blinking block
    "and the cursor in insert mode be a solid underscore
    let &t_SI = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[1 q"
    "make the cursor change back when leave vim
    autocmd VimLeave * silent !echo -ne "\033]112\007"
endif

"Make the cursor always stay 3 lines inside the window when scrolling
set scrolloff=3
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Mappings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <C-c> <ESC>

" macro to put spaces around a character - e.g. python operators
let @s='?\S[=*<+/>-]\Sls  P:nohlsearch'

"indentation in visual
vnoremap < <gv
vnoremap > >gv
nnoremap Y y$

" Remove trailing whitespace
" Run ctags
nnoremap <F9> :%s/\s\+$//<CR>
nnoremap <F12>  :!ctags -R --fields=+iaS --extra=+q .<CR><CR>

" Choose windows based on number
nnoremap <leader>1 :exe 1 . "wincmd w"<CR>
nnoremap <leader>2 :exe 2 . "wincmd w"<CR>
nnoremap <leader>3 :exe 3 . "wincmd w"<CR>
nnoremap <leader>4 :exe 4 . "wincmd w"<CR>
nnoremap <leader>5 :exe 5 . "wincmd w"<CR>
nnoremap <leader>6 :exe 6 . "wincmd w"<CR>
nnoremap <leader>7 :exe 7 . "wincmd w"<CR>
nnoremap <leader>8 :exe 8 . "wincmd w"<CR>
nnoremap <leader>9 :exe 9 . "wincmd w"<CR>
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Automation {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Automatically save and load folds for text files (program files will
"have the syntax folding on).
au BufWinLeave ?*.txt mkview
au BufWinEnter ?*.txt silent loadview
"NOTE the regex matches filenames, the ? is there so it doesn't match empty
"filenames, else there would be an error when opening help

" Insert and command-line only Caps-Lock
" make search and insert mode keymaps the same
" When toggle keymap (defined in vim/keymaps/insert_only_capslock), make sure
" the mapping is removed when leaving insert mode
set imsearch=-1
set keymap=insert_only_capslock
set iminsert=0
autocmd InsertLeave * set iminsert=0

"turn the plugin lookup on
"turn automatic filetype indentation on
filetype plugin on
filetype indent on

"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Completion {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If having problems with complete scanning /dev/null or /dev/random
" remove the search over included files
" set complete=.,w,b,u,t
set completeopt=menuone,menu,longest
" Lower priority tab completion
"search current and above directory for tag file
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set tags=./tags;$HOME
"change how the command line autocomplete works
"set wildmode=<parameters>
set smarttab
set shiftround
set autoread
set wildmenu
set wildignore=*.o,*.obj,*~,*.swp
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pyc,__pycache__/

"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Information {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"give me two lines to write commands out
"show commands as typing add line numbers
set showcmd
set showmode
set cmdheight=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}\ \ \ %{SyntasticStatuslineFlag()}%=%-14.(%l,%c%V%)\ %P
set ruler
set number


"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Miscellaneous {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Make split windows open on right and below by default
set splitright
set splitbelow
"Turn off the mouse
set mouse=""
" Backspaces and History
set backspace=indent,eol,start
set history=50
"Separate windows when scrolling
set nocursorbind
set noscrollbind
"Allows opening of buffers in the background
"don't make automatic backups
set nobackup
set hidden
"set bufhidden=hide

"Format options: automatic folding, comment folding etc.
set textwidth=79
set formatoptions+=crotql

"Make automatic open with folds all closed
" Give me enough time to think aobut which command I want
set foldlevelstart=0
set timeoutlen=1000

" Conceal text - define when it's not shown
set conceallevel=0
set concealcursor=nc

"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Printoptions {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"When printing, include numbers
"(only works if compiled with the correct options - not sure that's what's done
set printoptions=number:y
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim: foldmethod=marker
