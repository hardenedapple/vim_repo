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


" Don't remove settings from init.vim if under nvim.
if !has('nvim')
  set all&
endif
" I haven't had a chance to try out these tests, so I don't actually know if
" this is a nice way of distinguishing things. It looks like it would work.
let os_features = ['mac', 'macunix', 'win64', 'win32unix', 'win32']
if has('unix')
  let g:os = substitute(system('uname'), '\n', '', '')
else
  for feature in os_features
    if has(feature)
      let g:os = feature
      break
    endif
  endfor
endif
let g:working_on_solaris = helpers#working_environment(0) == 'solaris'

runtime bundle/pathogen/autoload/pathogen.vim

" Pathogen plugin {{{
" If don't want aky plugins, uncomment the second line here.
" If want to use completion use
" vim --cmd 'let g:pathogen_disabled = []' <filename>
" on the command line.
let g:pathogen_disabled = get(g:, 'pathogen_disabled', ['neomake', 'grepper', 'python-mode'])
if v:version < 704
  let g:pathogen_disabled += ['ultisnips']
endif
if v:version < 703
  let g:pathogen_disabled += ['ctrlp', 'ctrlp-funky', 'gundo', 'sneak', 'vimfindsme']
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

if !has('python') && !has('python3')
  let g:pathogen_disabled += ['gundo', 'ultisnips']
endif

if !has('python3')
  let g:pathogen_disabled += ['vsh']
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
        \  'commentary', 'ctrlp', 'ctrlp-funky', 'dentures',
        \  'dispatch', 'easygrep', 'eunuch', 'exchange', 'fugitive', 'gitv',
        \  'grepper', 'gnupg', 'gundo', 'lawrencium', 'linediff',
        \  'neomake', 'obsession',
        \  'pathogen', 'python-mode', 'repeat', 'rust-vim',
        \  'sexp', 'sexp_mappings',
        \  'sideways', 'sneak', 'snippets', 'submode', 'surround',
        \  'tabular', 'ultisnips', 'unimpaired', 'vimfindsme',
        \  'vimple', 'visualstar',
        \  'rtags', ]
endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Mappings {{{

" N.b. due to a different order between ftplugin and plugin getting loaded
" after a recent neovim change, if we set `mapleader` *after* running
" `syntax on` then since our vsh plugin will be loaded before `mapleader` is
" set it will not have access to the correct key on which to store mappings.
"
" Putting maps on <Leader> uses `\` by default if these variables are not
" defined (which is problematic for `mapleader` for me).
"
" There's not really anything that vsh can do for this.  I want to put mappings
" on <Leader> and <localleader>.  When those are not defined they should go on
" the default as per vim defaults.  There's not really a way to tell from the
" plugin whether `mapleader` was totally going to be defined later on, or
" whether the defaults were what the end-user wanted.
"
" Hence the only thing for it is for an end user (i.e. a users vimrc) to ensure
" that `mapleader` is set before the vsh plugin is loaded (or for that matter
" any other plugins which put mappings on <leader> and <localleader>).  Since
" it's the `syntax on` part of this vimrc which triggers loading the ftplugin
" for the filetype specified on the command line, and it's the ftplugin for vsh
" that ends up defining mappings, we ensure that these lines are before
" `syntax on` below.
"
" (For ordering behaviour see https://github.com/neovim/neovim/issues/19008)
let mapleader=" "
let maplocalleader="\\"

" Don't timeout waiting for key mappings.
set notimeout

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
nnoremap <leader>er  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Edit the current makeprg
nnoremap <leader>em  :<C-U><C-R><C-R>='let &makeprg="' . &makeprg . '"'<CR><C-F><left>

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
" Used to have '| copen' at the end of this, but then the cursor jumps to the
" quickfix window.
"
" I have two versions because with the vimgrep version we're stuck when working
" in buffers that don't have an underlying file, or with files that have
" strange names.
" The function version is really slow in large files (e.g. 300,000 lines in
" some weechat logs).
" The function is mostly taken from man#show_toc()
function OccurSearch(pattern, word_match, add) abort range
  let pattern = a:word_match ? '\<' . a:pattern . '\>' : a:pattern
  let bufname = bufname('%')
  let info = getqflist({'title': 1})
  let title = 'Occur: '. bufname . ' ' . pattern . ' ' . a:firstline . ',' . a:lastline
  " Using get() is required for vim in case the quickfix dictionary returned
  " doesn't have a title.
  " One time when this happens is just after starting the program up.
  " This isn't a worry in neovim.
  if get(info, 'title', '') ==# title && !a:add
    return
  endif

  let entries = []
  let lnum = a:firstline
  while lnum && lnum <= a:lastline
    let text = getline(lnum)
    if text =~# pattern
      call add(entries, {'bufnr': bufnr('%'), 'lnum': lnum, 'text': text})
    endif
    let lnum = lnum + 1
  endwhile

  call setqflist(entries, a:add ? 'a' : ' ')
  if !a:add
    call setqflist([], 'a', {'title': title})
  endif
endfunction

command -range=% -bang -bar -nargs=1 Occur <line1>,<line2>call OccurSearch(<q-args>, <bang>0, 0)
command -range=% -bang -bar -nargs=1 Occuradd <line1>,<line2>call OccurSearch(<q-args>, <bang>0, 1)
command -range=% -bang -bar -nargs=1 OccurFast execute 'silent vimgrep /' . substitute('<bang>', '!', '\\<', '') . <q-args> . substitute('<bang>', '!', '\\>', '') . '/j ' . expand('%') ' | call helpers#FilterQuickfixListByPosition(0, <line1>, <line2>, v:false) | call helpers#open_list_unobtrusively("", "copen")'
nnoremap <silent> <leader>sh :OccurFast <C-R><C-W><CR>

" Remove trailing whitespace
" Purposefully set mappings to not remove any automatic range added.
" For the `nnoremap` version this allows pressing things like `4<F10>` to clear
" whitespace from the next 4 lines.
" For the `vnoremap` version this leaves the current visual range as the range
" the mapping will act on.
nnoremap <silent> <F10> :s/\s\+$//<CR>:nohlsearch<CR>
vnoremap <silent> <F10> :s/\s\+$//<CR>:nohlsearch<CR>

if !helpers#external_program_missing('ctags')
  if g:working_on_solaris
    " NOTE -- for Solaris I have to manually make sure the ctags version I'm
    " using is the gnu version they give by linking /usr/gnu/bin/ctags into
    " ~/bin/ctags.
    " Even then it's not the same kind I get on Linux, so I need different
    " flags.
    nnoremap <F12>  :<C-U>!ctags -tdT --globals --members *.c *.h <CR> <CR>
  else
    nnoremap <F12>  :<C-U>!ctags-exuberant -R --fields=+iaS --extra=+qf .<CR><CR>
  endif
endif

nnoremap <F9> :<C-U>make<CR>

nnoremap <silent> <leader>nh :<C-U>nohlsearch<CR>
nnoremap <silent> <leader>ny :<C-U>call helpers#default_search()<CR>
nnoremap <silent> <leader>ng :<C-U>call helpers#restore_search()<CR>
nnoremap <silent> <leader>nw :<C-U>call helpers#where_cursor()<CR>

nnoremap <silent> <leader>cl :<C-U>setlocal completeopt+=longest<CR>
nnoremap <silent> <leader>cn :<C-U>setlocal completeopt-=longest<CR>

" Choose windows based on number
nnoremap <silent> g1 :<C-U>exe 1 . "wincmd w"<CR>
nnoremap <silent> g2 :<C-U>exe 2 . "wincmd w"<CR>
nnoremap <silent> g3 :<C-U>exe 3 . "wincmd w"<CR>
nnoremap <silent> g4 :<C-U>exe 4 . "wincmd w"<CR>
nnoremap <silent> g5 :<C-U>exe 5 . "wincmd w"<CR>
nnoremap <silent> g6 :<C-U>exe 6 . "wincmd w"<CR>

nnoremap <leader>p, :keeppatterns s/,/,\r/g<CR>

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
" Save the current line as a vimcmd so I can reference it in some other file.
" Thought about having a full pathname, so the cwd of the vim process doesn't
" matter, but a) I don't like the look of it, and b) it makes moving entire
" directories a pain.
nnoremap <silent><leader>es :<C-U>let @" = 'vimcmd: e +' . line('.') . ' ' . expand('%')<CR>
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
"Manage spaces and tabs {{{

" Indentation settings taken from GNU coding standards
" (may as well have them everywhere rather than rely on telling which files are
" for GNU and which aren't).
set autoindent
set noexpandtab
set shiftwidth=2
set tabstop=8
set softtabstop=2

" Insert double spaces for a new sentence.  This is the GNU comment style.
" Previously I didn't like it, but I'm now used to it.
" set nojoinspaces
set joinspaces
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

if !has('win32')
  au BufWritePost * call MakeExecutableIfScript()
endif

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

function SortByLength(reverse) range abort
  let lines_to_sort = getline(a:firstline, a:lastline)
  if a:reverse
    call setline(a:firstline, reverse(sort(lines_to_sort, "CompareLength")))
  else
    call setline(a:firstline, sort(lines_to_sort, "CompareLength"))
  endif
endfunction

command -bang -range Lensort <line1>,<line2>call SortByLength(<bang>0)

" NOTE: it appears that a `range` attribute on one function doesn't get passed
" over vimL calls.
" In other words, executing `call ReplaceText(lines)` in the ReplaceReg()
" function doesn't give ReplaceText() the correct a:firstline and a:lastline
" arguments.
" This is why there's this implementation function that takes range arguments
" explicitly.
function ReplaceShared(lines, first, last) abort
  " Question is: Do I want to save the original lines?
  " I'm currently leaning towards "yes", but I may get annoyed by this in the
  " future.
  execute 'silent 'a:first.','.a:last.'d'
  call append(a:first - 1, a:lines)
  " Want to leave '[ and '] surrounding the text we just inserted.
  " Putting '] on the last inserted character matches the behaviour of 'p' on a
  " linewise register.
  call setpos("']", [0, a:first + len(a:lines) - 1, len(a:lines[-1]), 0])
  echom (a:last - a:first + 1) . ' lines replaced with ' . len(a:lines) . ' lines'
endfunction
function ReplaceText(lines) range abort
  call ReplaceShared(a:lines, a:firstline, a:lastline)
endfunction
function ReplaceReg(...) range abort
  let register = a:0 == '' ? v:register : a:1
  call ReplaceShared(getreg(register, 1, v:true), a:firstline, a:lastline)
endfunction

command -bar -register -range ReplaceReg <line1>,<line2>call ReplaceReg(<reg>)
command -bar -range -nargs=+ Replace <args>call ReplaceText(getline(<line1>,<line2>))
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Completion {{{

"Don't scan included files - takes too long and can use <C-x><C-i>
set complete=.,w,b,u,t
set completeopt=menu
" Lower priority tab completion
set suffixes+=.log,.bak,.out,.info,.png,.jpg,.fasl,.o,.obj,.gif,.xpm,.pdf
"search current and above directory for tag file
set tags=./tags;$HOME
"change how the command line autocomplete works
"set wildmode=<parameters>
set smarttab
set shiftround
set autoread
set wildmenu
set wildmode=full
set wildignore+=*.pyc,__pycache__/,*~,.*.swp,*.aux,*.dvi,*.bbl,*.blg,*.brf,*.toc,*.lof

" if ignorecase is on, use the case of the matching pattern to choose the case
" of the insertion pattern to insert -- I rarely use ignorecase, but when I do,
" this comes in handy.
set infercase
set noignorecase

" TODO Make this work on the word just before the cursor instead of simply the
" last word on the command line.
" TODO Is there any way to make things like `:b %:h/Lib/%:t:r.cpp` work?
function s:expand_commandline()
  " This function doesn't make sense to be called outside of command line mode:
  " 1) The method it takes to find the last expression uses `getcmdline()`.
  " 2) In a normal buffer it's easier to select what you just inserted, and
  " expand it, you can just wait until your edit finishes and do that in normal
  " mode.
  " 3) I don't find myself wanting to expand vimL ex
  if mode() != 'c'
    return ''
  endif
  let currentline = getcmdline()
  let last_element = split(currentline)[-1]
  let expanded_element = expand(last_element)
  " expand() returns empty if it doesn't recognise the argument.
  if expanded_element == ''
    return ''
  endif
  " Can't simply join() the split line for fear of removing spaces that matter.
  " :somecommand "  " %:h
  " Could use something like
  " return "\<C-u>" . currentline[:- len(last_element) - 1] . expanded_element
  " But I like the below as it matches what I would do manually
  " (i.e. I type out the expression, then go "bother", delete it, and insert
  " the expansion instead).
  return repeat("\<BS>", len(last_element)) . expanded_element
endfunction
cnoremap <expr> <C-x> <SID>expand_commandline()

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

" Default for vim, but neovim turns it off.
set belloff=
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

" " Make the search path include current directory, directory of current buffer,
" " and directories below.
" " Previously I've used **, but for now I'm trying out using the default.
" " This should ensure that searching never
" set path=.,**,,

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
command Unbind windo set nocursorbind noscrollbind
" Buffer switching
set hidden
"set bufhidden=hide

" Have the equivalent of programming keyboards when in insert mode, while
" keeping numbers easy to press in command mode.
set keymap=shifted_keys
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
" Give me enough time to think about which command I want
set foldlevelstart=0
set timeoutlen=1000

" incremental searches
set incsearch

" When running under zsh, have a problem with 'grep -s ...'
" could do stuff with NO_NOMATCH, but for compatibility with other boxes, just
" use bash
if has('unix')
  set shell=bash
elseif has('win32')
  set shell=powershell.exe
endif

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

" Setting for TOhtml command
" I try to avoid Javascript (for no real reason) whenever I can.
let g:html_number_lines = 0
let g:html_line_ids = 0
let g:html_expand_tabs = 0

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

" {{{ Windows options
if has('win32')
  noremap <C-6> <C-^>
  noremap! <C-6> <C-^>
endif
" }}}

" vim: foldmethod=marker
