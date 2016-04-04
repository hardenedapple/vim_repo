"This is my vim Customisation file.
" NOTE: Function keys
"       <F1> - Help (as usual for vim)
"       <F2> - Run vimcmd on this line.
"       <F3> - Ultisnips list completions
"       <F4> -
"       <F5> - GundoToggle
"       <F6>
"       <F7> -
"       <F8> - switch through colours
"       <F9> - Dispatch
"       <F10> - Remove trailing whitespace
"       <F11> - (in C/C++) cscope update
"       <F12> - ctags update


set all&
let g:os = substitute(system('uname'), '\n', '', '')
if g:os == "SunOS"
  let g:working_on_solaris = 1
else
  let g:working_on_solaris = 0
endif

runtime bundle/pathogen/autoload/pathogen.vim

" Pathogen plugin {{{
" If don't want aky plugins, uncomment the second line here.
" If want to use completion use
" vim --cmd 'let g:pathogen_disabled = []' <filename>
" on the command line.
let g:pathogen_disabled = get(g:, 'pathogen_disabled', ['clang_complete', 'neomake'])
if v:version < 704
  let g:pathogen_disabled += ['ultisnips']
endif
if v:version < 703
  let g:pathogen_disabled += ['clang_complete', 'ctrlp', 'ctrlp-funky', 'gundo', 'sneak', 'vimfindsme']
endif
if v:version < 702
  let g:pathogen_disabled += ['airline', 'gnupg']
endif
if v:version < 701
  let g:pathogen_disabled += ['abolish']
endif
if v:version < 700
  let g:pathogen_disabled += ['commentary', 'dispatch', 'easygrep', 'eunuch',
        \ 'gitv', 'obsession', 'repeat', 'surround', 'snippets',
        \ 'unimpaired', 'vimple']
endif

if !has('python')
  let g:pathogen_disabled += ['jedi', 'vim-ipython', 'clang_complete', 'gundo', 'ultisnips']
else
python << EOF
try:
  import jedi
except ImportError:
  import vim
  try:
    vim.vars['pathogen_disabled'].extend(['jedi'])
  except AttributeError:
    vim.command("let g:pathogen_disabled += ['jedi']")
EOF
endif

" Check external dependencies -- clang, ipython, and git
if helpers#external_program_missing('clang')
  let g:pathogen_disabled += ['clang_complete']
endif

if helpers#external_program_missing('ipython3') && helpers#external_program_missing('ipython2')
  let g:pathogen_disabled += ['vim-ipython']
endif

if helpers#external_program_missing('hg')
  let g:pathogen_disabled += ['lawrencium']
endif

if helpers#external_program_missing('git')
  let g:pathogen_disabled += ['fugitive',  'gitv']
endif

" Check plugin-plugin dependencies
if index(g:pathogen_disabled, 'fugitive') != -1
  let g:pathogen_disabled += ['gitv']
endif
if index(g:pathogen_disabled, 'ctrlp') != -1
  let g:pathogen_disabled += ['ctrlp-funky']
endif

if exists('*pathogen#infect()') && !exists('g:no_plugins') && (has('win32') || system('id -u') != 0)
  execute pathogen#infect()
else
  " If no pathogen, disable all the plugin settings I have.
  let g:pathogen_disabled = [ 'abolish', 'airline', 'arduinosyntax',
        \  'clang_complete', 'commentary', 'ctrlp', 'ctrlp-funky', 'dentures',
        \  'dispatch', 'easygrep', 'eunuch', 'exchange', 'fugitive', 'gitv',
        \  'gnupg', 'gundo', 'jedi', 'lawrencium', 'neomake', 'obsession',
        \  'pathogen', 'python-mode', 'repeat', 'sexp', 'sexp_mappings',
        \  'sideways', 'sneak', 'snippets', 'submode', 'surround', 'syntastic',
        \  'tabular', 'ultisnips', 'unimpaired', 'vimfindsme', 'vim-ipython',
        \  'vimple', 'visualstar', ]
endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Manage spaces and tabs {{{

"stay indented when getting new line
set autoindent
set shiftwidth=4

"make a tab change to 4 spaces
set expandtab
set tabstop=4

set nojoinspaces
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Errorbells {{{

"Don't keep bugging me whenever I type something wrong
set noerrorbells
set visualbell
set t_vb=
set tm=500

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look/Appearance {{{

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

" If in C and using syntax folding, don't fold comments
" (is here not after/ftplugin as has to be active when syntax/c.vim is read)
let g:c_no_comment_fold = 1

"get vim to automatically highlight based on syntax and file extension
syntax on
filetype on
" cursorline/column
set nocursorcolumn
set nocursorline
color techras
" If in xterm, use control sequences to control cursor
if &term == "xterm-256color" || &term == "xterm" || &term == "screen-256color"
    "Make the cursor in command mode be a blinking block
    "and the cursor in insert mode be a solid underscore
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
    "make the cursor change back when leave vim
    autocmd VimLeave * silent !echo -ne "\033]112\007"
endif

if &term =~ '^screen'
    " When inside xterm, inside screen, the Shift and Ctrl modifiers don't
    " work well -- here i'm manually adding the mappings for xterm keys,
    " Do this as my tmux configuration sets the use of xterm keys for these
    " modifiers.
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"Make the cursor always stay 3 lines inside the window when scrolling
set scrolloff=3
set nowrap

" Conceal text - define when it's not shown
if v:version > 703
  set conceallevel=0
  set concealcursor=nc
endif

" Specify some color groups for :match to use
highlight link match1 ColorColumn
highlight link match2 Todo

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Mappings {{{

let mapleader=" "
let maplocalleader="\\"

" macro to put spaces around a character - e.g. python operators
let @s='?\S[=*<+/>-]\Slcl  P:nohlsearch'

" indentation in visual
vnoremap < <gv
vnoremap > >gv

" Highlight last modified text
nnoremap <expr> gV "`[".getregtype(v:register)[0]."`]"

" make Y match other capitals
nnoremap Y y$

" Make cw consistent with the rest of vim -- doesn't help with c<n>w
nnoremap cw dwi

" Reverse whether going to exact position or linewise in motions
noremap ' `
noremap ` '

" Mapping from vimcast 62
nnoremap <silent> Q :normal n.<CR>

" Quicker looking at buffers
nnoremap <leader>b :ls<CR>:b<space>

" Quick save
nnoremap <silent> <leader>s :up<CR>

" Put occurances of current word in quickfix
command -bang -bar -nargs=1 Occur execute 'silent vimgrep /' . substitute('<bang>', '!', '\\<', '') . <q-args> . substitute('<bang>', '!', '\\>', '') . '/j ' . expand('%') . ' | copen'
nnoremap <silent> <leader>vh :Occur! <C-R><C-W><CR>

" Mouse mappings -- for code browsing when not changing anything.
" NOTE: <LeftMouse> just goes to that position, g<RightMouse> pops the tag
" stack.
" g<LeftMouse> already follows the current tag, but I'm trying to follow what
" acme does because I've already learned that.
vnoremap <LeftRelease> <LeftRelease>"*ygv

" Currently, I have a problem in Man pages -- g<RightMouse> is supposed to pop
" the tag stack, but ftplugin/man.vim overrides C-t to go back to the previous
" man page.
" Hence in man pages, the g<RightMouse> mapping just doesn't work.
nnoremap <RightMouse> <LeftMouse>:silent call helpers#plumb_this()<CR>
nnoremap q<RightMouse> <C-O>
nnoremap q<LeftMouse> <C-I>
nnoremap f<RightMouse> <LeftMouse>:silent Occur <C-R><C-W><CR>
nnoremap F<RightMouse> <LeftMouse>:silent Occur! <C-R><C-W><CR>

" Remove trailing whitespace
nnoremap <silent> <F10> :%s/\s\+$//<CR>:nohlsearch<CR>

if !helpers#external_program_missing('ctags')
  if g:working_on_solaris
    " NOTE -- for Solaris I have to manually make sure the ctags version I'm
    " using is the gnu version they give by linking /usr/gnu/bin/ctags into
    " ~/bin/ctags.
    " Even then it's not the same kind I get on Linux, so I need different
    " flags.
    nnoremap <F12>  :!ctags -tdT --globals --members *.c *.h <CR> <CR>
  else
    nnoremap <F12>  :!ctags -R --fields=+iaS --extra=+qf .<CR><CR>
  endif
endif

nnoremap <F9> :make<CR>

nnoremap <silent> <leader>nh :nohlsearch<CR>

nnoremap <silent> <leader>cl :setlocal completeopt+=longest<CR>
nnoremap <silent> <leader>cn :setlocal completeopt-=longest<CR>

" Choose windows based on number
nnoremap <silent> g1 :exe 1 . "wincmd w"<CR>
nnoremap <silent> g2 :exe 2 . "wincmd w"<CR>
nnoremap <silent> g3 :exe 3 . "wincmd w"<CR>
nnoremap <silent> g4 :exe 4 . "wincmd w"<CR>
nnoremap <silent> g5 :exe 5 . "wincmd w"<CR>
nnoremap <silent> g6 :exe 6 . "wincmd w"<CR>

" Execute current line or current selection as Vim EX commands.
" (I've just been watching the acme editor introduction)
let g:command_prefix = 'vimcmd: '
function s:ParseCommand(line)
  let l:command_start = match(a:line, g:command_prefix)
  if l:command_start != -1
    return a:line[l:command_start + len(g:command_prefix):]
  else
    return ''
  endif
endfunction

function RunCommand(val)
  if v:count == 0 || a:val
    let line = getline('.')
  else
    let line = getline(v:count)
  endif
  let commandLine = s:ParseCommand(l:line)
  if l:commandLine == ''
    echom 'Cannot parse line ' . l:line . ' for command, require prefix -- "' . g:command_prefix . '"'
  else
    execute l:commandLine
  endif
endfunction

nnoremap <silent> <F2> :<C-u>call RunCommand(0)<CR>
vnoremap <silent> <F2> y:<C-u>exe getreg('"')<CR>
command -range RunCommand execute 'keeppatterns' <line1> . ',' . <line2> . 'global/' . g:command_prefix . '/call RunCommand("1")'
nnoremap <MiddleMouse> <LeftMouse>:silent RunCommand<CR>

" In Dvorak, keep completion commands nearer each other
inoremap <C-b> <C-p>

" j and k keys below the 4 key in Dvorak
noremap <silent> gj @='4j'<CR>
noremap <silent> gk @='4k'<CR>

" For my specific keyboard layout
noremap <leader>' :
noremap <leader>z :

noremap ; ,
noremap , ;

"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Automation {{{
filetype plugin on
filetype indent on

" Set scripts to be executable from the shell
function MakeExecutableIfScript()
    if getline(1) =~ "^#!"
        if getline(1) =~ "/bin/"
            silent !chmod +x <afile>
        endif
    endif
endfunction

au BufWritePost * call MakeExecutableIfScript()

" When executing automatic commands, wait until finished
set lazyredraw

" Scratch file function from http://dhruvasagar.com/tag/vim
function ScratchEdit(cmd, options)
    exe a:cmd tempname()
    setlocal buftype=nofile bufhidden=wipe nobuflisted
    if !empty(a:options) | exe 'setl' a:options | endif
endfunction

command -bar -nargs=* Sedit call ScratchEdit('edit', <q-args>)
command -bar -nargs=* Ssedit call ScratchEdit('split', <q-args>)
command -bar -nargs=* Svedit call ScratchEdit('vsplit', <q-args>)
command -bar -nargs=* Stabedit call ScratchEdit('tabe', <q-args>)

" Function to move/copy lines whether they're inside folds or not
command -nargs=* O call WithOpenFolds(<q-args>)

function WithOpenFolds(command)
  normal zn
  execute a:command
  normal zN
endfunction

"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filters {{{
function CompareLength(line1, line2) abort
    let [length1, length2] = [strchars(a:line1), strchars(a:line2)]
    if length1 < length2
        return 1
    else
        if length1 > length2
            return -1
        else
            return 0
        endif
    endif
endfunction

function SortByLength(reverse) abort
    let lines_to_sort = getline(a:firstline, a:lastline)
    if a:reverse
        call setline(a:firstline, reverse(sort(lines_to_sort, "CompareLength")))
    else
        call setline(a:firstline, sort(lines_to_sort, "CompareLength"))
    endif
endfunction

command -bang -range Lensort <line1>,<line2>call SortByLength(<bang>0)
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Completion {{{

"Don't scan included files - takes too long and can use <C-x><C-i>
set complete=.,w,b,u,t
set completeopt=menu
" Lower priority tab completion
set suffixes+=.png,.jpg,.fasl,.o,.obj,.gif,.xpm,.pdf,.bak,.info,.out
"search current and above directory for tag file
set tags=./tags;$HOME
"change how the command line autocomplete works
"set wildmode=<parameters>
set smarttab
set shiftround
set autoread
set wildmenu
set wildmode=full
set wildignore+=*.pyc,__pycache__/,*~,.*.swp,*.aux,*.log,*.dvi,*.bbl,*.blg,*.brf,*.toc,*.lof

" if ignorecase is on, use the case of the matching pattern to choose the case
" of the insertion pattern to insert -- I rarely use ignorecase, but when I do,
" this comes in handy.
set infercase
set noignorecase

"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Information {{{

"give me two lines to write commands out
"show commands as typing add line numbers
"don't save options when using mksession (interferes with plugins)
set showcmd
set showmode
set cmdheight=2
set shortmess=aOtT
if has('patch-7.4.314')
  set shortmess+=c
endif
set ruler
set number
set sessionoptions-=options

"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Netrw

" Make gx open the file under cursor with whatever program it requires.
" NOTE: URL's require 'http://' at the front
let g:netrw_browsex_viewer = "xdg-open"

" Default browser liststyle
let g:netrw_liststyle=3

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Persistance {{{
if has('nvim')
  set shada='100,<50,s10,h,/50,:50,@50,f1,r/tmp,r/mnt,r/media,n~/.config/nvim/neoshada
else
  set viminfo='100,<50,s10,h,/50,:50,@50,f1,r/tmp,r/mnt,r/media
  if has('win32')
    set viminfo+=n~/vimfiles/viminfo
  else
    set viminfo+=n~/.vim/viminfo
  endif
endif
set nobackup
set history=50
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Behaviour {{{

" Make the search path include current directory, directory of current buffer,
" and directories below.
set path=.,**,,

" Make split windows open on right and below by default
set splitright
set splitbelow
set mouse=a
" Backspaces and History
set backspace=indent,eol,start
" Separate windows when scrolling
if v:version > 703
  set nocursorbind
endif
set noscrollbind
" Buffer switching
set hidden
"set bufhidden=hide

" Have the equivalent of programming keyboards when in insert mode, while
" keeping numbers easy to press in command mode.
set keymap=shifted_numbers
" Don't really know what input method (IM) in the manual is, so don't really
" want to disable it in case it's something useful, but neovim complains for
" 'imsearch' = 2, so am using 0 for now.
set imsearch=0

" Format options: automatic folding, comment folding etc.
set textwidth=79
set formatoptions+=crotql
set virtualedit=block

" Make automatic open with folds all closed
" Give me enough time to think aobut which command I want
set foldlevelstart=0
set timeoutlen=1000

" incremental searches
set incsearch

" When running under zsh, have a problem with 'grep -s ...'
" could do stuff with NO_NOMATCH, but for compatibility with other boxes, just
" use bash
set shell=/bin/bash

" Options for future investigation:
"   set secure
"   set exrc
"   set ttyfast
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Printoptions {{{

"When printing, include numbers
"(only works if compiled with the correct options - not sure that's what's done
set printoptions=number:y

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Solaris Options
if g:os == 'SunOS'
  set grepprg=ggrep\ -n\ $*\ /dev/null
  set makeprg=gmake
endif
" }}}

" vim: foldmethod=marker
