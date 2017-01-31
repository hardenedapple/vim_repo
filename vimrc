"This is my vim Customisation file.
" NOTE: Function keys
"       <F1> - Help (as usual for vim)
"       <F2> - Run vimcmd on this line.
"     i_<F3> - Ultisnips list completions
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
let g:pathogen_disabled = get(g:, 'pathogen_disabled', ['clang_complete', 'neomake', 'grepper'])
if v:version < 704
  let g:pathogen_disabled += ['ultisnips']
endif
if v:version < 703
  let g:pathogen_disabled += ['clang_complete', 'ctrlp', 'ctrlp-funky', 'gundo', 'sneak', 'vimfindsme']
endif
if v:version < 702
  let g:pathogen_disabled += ['gnupg']
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
  let g:pathogen_disabled = [ 'abolish', 'arduinosyntax',
        \  'clang_complete', 'commentary', 'ctrlp', 'ctrlp-funky', 'dentures',
        \  'dispatch', 'easygrep', 'eunuch', 'exchange', 'fugitive', 'gitv',
        \  'gnupg', 'gundo', 'jedi', 'lawrencium', 'neomake', 'obsession',
        \  'pathogen', 'python-mode', 'repeat', 'rust-vim',
        \  'sexp', 'sexp_mappings',
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

" Define the statusline.
set statusline=%<\ %f\ #%n\ %h%m%r%=%k\ %-14.(%l,%c%V%)\ %P

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

" Some stuff from https://github.com/mhinz/vim-galore
nnoremap <C-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
nnoremap <leader>em  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Mapping from vimcast 62
function s:Again()
  let numtimes = v:count1
  let i = 0
  while i < l:numtimes
    normal! n.
    let i += 1
  endwhile
endfunction
nnoremap <silent> Q :<C-U>call <SID>Again()<CR>

" Quicker looking at buffers
nnoremap <leader>b :<C-U>ls<CR>:b<space>

" Quick save
nnoremap <silent> <leader>u :<C-U>update<CR>

" Put occurances of current word in quickfix
command -bang -bar -nargs=1 Occur execute 'silent vimgrep /' . substitute('<bang>', '!', '\\<', '') . <q-args> . substitute('<bang>', '!', '\\>', '') . '/j ' . expand('%') . ' | copen'
nnoremap <silent> <leader>sh :<C-U>Occur! <C-R><C-W><CR>

" Mouse mappings -- for code browsing when not changing anything.
" NOTE: <LeftMouse> just goes to that position, this should be kept constant.
vnoremap <LeftRelease> <LeftRelease>"*ygv

nnoremap <RightMouse> <LeftMouse>:<C-U>silent call helpers#plumb_this()<CR>
nnoremap q<RightMouse> <C-O>
nnoremap q<LeftMouse> <C-I>
nnoremap f<RightMouse> <LeftMouse>:<C-U>silent Occur <C-R><C-W><CR>
nnoremap F<RightMouse> <LeftMouse>:<C-U>silent Occur! <C-R><C-W><CR>
" NOTE: in order to make this mapping work with ftplugin/man.vim reading man
" pages, I have to use nmap.
" This is because it maps <C-T> to 'go back a man page', which I need to use,
" and the function that implements that functionality is script-local.
" Hence -- watch out for this, be careful to not map <LeftMouse> to anything
" that will change this behaviour.
nmap '<LeftMouse> <LeftMouse><C-T>

" Remove trailing whitespace
nnoremap <silent> <F10> :<C-U>%s/\s\+$//<CR>:nohlsearch<CR>

if !helpers#external_program_missing('ctags')
  if g:working_on_solaris
    " NOTE -- for Solaris I have to manually make sure the ctags version I'm
    " using is the gnu version they give by linking /usr/gnu/bin/ctags into
    " ~/bin/ctags.
    " Even then it's not the same kind I get on Linux, so I need different
    " flags.
    nnoremap <F12>  :<C-U>!ctags -tdT --globals --members *.c *.h <CR> <CR>
  else
    nnoremap <F12>  :<C-U>!ctags -R --fields=+iaS --extra=+qf .<CR><CR>
  endif
endif

nnoremap <F9> :<C-U>make<CR>

nnoremap <silent> <leader>nh :<C-U>nohlsearch<CR>

nnoremap <silent> <leader>cl :<C-U>setlocal completeopt+=longest<CR>
nnoremap <silent> <leader>cn :<C-U>setlocal completeopt-=longest<CR>

" Choose windows based on number
nnoremap <silent> g1 :<C-U>exe 1 . "wincmd w"<CR>
nnoremap <silent> g2 :<C-U>exe 2 . "wincmd w"<CR>
nnoremap <silent> g3 :<C-U>exe 3 . "wincmd w"<CR>
nnoremap <silent> g4 :<C-U>exe 4 . "wincmd w"<CR>
nnoremap <silent> g5 :<C-U>exe 5 . "wincmd w"<CR>
nnoremap <silent> g6 :<C-U>exe 6 . "wincmd w"<CR>

" Execute current line or current selection as Vim EX commands.
" (I've just been watching the acme editor introduction)
let g:command_prefix = 'vimcmd: '
function s:ParseCommand(line)
  let come_here_prefix = substitute(g:command_prefix, ':', ';', '')
  let come_and_stay_prefix = substitute(g:command_prefix, ':', '!', '')

  let l:command_start = match(a:line, g:command_prefix)
  if l:command_start != -1
    return [0, a:line[l:command_start + len(g:command_prefix):]]
  end

  let l:command_start = match(a:line, come_here_prefix)
  if l:command_start != -1
    return [1, a:line[l:command_start + len(g:command_prefix):]]
  end

  let l:command_start = match(a:line, come_and_stay_prefix)
  if l:command_start != -1
    return [2, a:line[l:command_start + len(g:command_prefix):]]
  end

  return [0, '']
endfunction

function RunCommand(val)
  let orig_vcount = 0
  if v:count == 0 || a:val
    let line = getline('.')
  else
    let orig_vcount = v:count
    let line = getline(orig_vcount)
  endif

  let commandLine = s:ParseCommand(l:line)
  if l:commandLine[1] == ''
    echom 'Cannot parse line ' . l:line . ' for command, require prefix -- "' . g:command_prefix . '"'
  end

  if l:commandLine[0] > 0 && orig_vcount
    exe orig_vcount
  end

  execute l:commandLine[1]

  if l:commandLine[0] > 1 && !a:val
    exe "''"
  end
endfunction

nnoremap <silent> <F2> :<C-u>call RunCommand(0)<CR>
vnoremap <silent> <F2> y:<C-u>exe getreg('"')<CR>
if exists(":keeppatterns")
  command -range RunCommand execute 'keeppatterns' <line1> . ',' . <line2> . 'global/' . g:command_prefix . '/call RunCommand("1")'
else
  command -range RunCommand execute <line1> . ',' . <line2> . 'global/' . g:command_prefix . '/call RunCommand("1")'
endif
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
  let firstline = getline(1)
  if l:firstline =~ "^#!"
    if l:firstline =~ "/bin/"
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

" Internal :Man command
set keywordprg=:Man

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
" {{{ Add _/- swapping
" We add these swaps here rather than include them in the 'keymap' to allow
" filetype plugins to unmap them with the commands
" lnoremap <buffer> - -
" lnoremap <buffer> _ _
" This doesn't work if the swaps are defined in 'keymap' because the 'keymap'
" option is set *after* the ftplugins in the after/ directory are loaded, and
" they are buffer-local.
" The 'keymap' mapings hence override the mappings defined in the
" after/ftplugin/ directory.
lnoremap _ -
lnoremap - _
" }}}
" To make things explicit, setting 'iminsert' to 1 (setting 'keymap' already
" sets 'iminsert' to 1 implicitly).
set iminsert=1
" Search patterns follow whether I'm currently typing in shifted keys or not.
set imsearch=-1
" Don't switch numbers and symbols for command line -- more often using a range
" than not.
" This is the default, so there's no reason to use this, but it serves as a
" reminder.
set noimcmdline

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

" Cscope settings
if has('cscope')
  set cscopetag
  set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
  set cscoperelative
  set cscopetagorder=0
  set cscopepathcomp=3
  set cscopeverbose
  " Search through all upper levels to find the cscope database (taken from
  " vim.wikia.com/wiki/Autoloading_Cscope_Database)
  function LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
      let path = strpart(db, 0, match(db, "/cscope.out$"))
      set nocscopeverbose " suppress 'duplicate connection' error
      exe "cs add " . db . " " . path
      set cscopeverbose
    endif
  endfunction
  " Call the function on startup.
  call LoadCscope()
endif


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
