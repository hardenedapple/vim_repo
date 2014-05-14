"This is my attempt at converting my vim colorscheme to a gvim colorscheme
"Initiallly just copy the cterm options, then transfer using the code
"On the internet.

"Would like to Define a font specifically for this colorscheme
"It would be the same font as my terminal font, but I don't think
"I have that font on gvim at the moment.

"TODO:
"   Make some difference between strings and numbers.
"   Add python, c++ and vim specific options
"   (I only use those, won't know what looks good with others.

hi clear

set background=dark
if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="techras"

hi Normal    guifg=#ffffff guibg=#000000

" GUI section
" {{{ Cursor
"Haven't got anything for Cursor - figure it out later
hi Cursor        guibg=#bbbbbb
hi CursorLine      guibg=#101010
hi CursorColumn  guibg=#101010
"Not sure if I want to change this or not.
hi CursorLineNr  gui=NONE guifg=Yellow
" }}}

" {{{ Diff
hi DiffAdd                       guibg=#003f00
hi DiffChange                    guibg=#2f002f
hi DiffText                      guibg=#002f3f gui=italic
hi DiffDelete     guifg=#3f3f00  guibg=#3f0000
" }}}

" {{{ Folding / Line Numbering / Status Lines
hi Folded    guifg=#878700 guibg=NONE gui=bold
"hi vimFold     guibg=#ECECEC guifg=#808080 gui=bold
hi FoldColumn    guifg=#00ffff guibg=NONE gui=NONE

hi LineNr     guifg=#008000  guibg=NONE gui=NONE
hi NonText   guifg=#0000ff guibg=NONE gui=NONE

hi VertSplit     guifg=#00ffd7 guibg=NONE gui=NONE
hi StatusLine    guifg=#00ffff guibg=NONE gui=NONE
hi StatusLineNC  guifg=#303030 guibg=NONE gui=NONE
" }}}


" {{{ Misc
hi ModeMsg   gui=bold
hi MoreMsg   guifg=#008000

hi Title     guifg=#800080
hi WarningMsg    guifg=#800000
hi SpecialKey    guifg=#000080

hi MatchParen    guibg=#00ffff
hi Underlined    guifg=#800080 gui=underline
hi Directory     guifg=#000080
" }}}

" {{{ Search, Visual, etc
"NOTE: I don't actually like the Visual defaults, will want to change these
hi Visual    guibg=#00003f
hi VisualNOS     gui=bold
"Not sure what this is - will have to find out
hi IncSearch     gui=reverse
hi Search    guibg=#576f2f
" }}}

" {{{ Syntax groups
hi Ignore       guifg=#ffffff
hi Identifier   guifg=#00ffff
hi PreProc      guifg=#c000c0
hi Comment      guifg=#005fff gui=italic
hi Constant     guifg=#005faf
hi String       guifg=#ff0000
hi Function     guifg=#00ffff
hi Statement    guifg=#ff8700 gui=NONE
hi Type         guifg=#00ff00  gui=NONE
hi Number       guifg=#ff0000
" don't like this - want to improve
hi Todo  guifg=#000000 guibg=#ffff00
hi Special   guifg=#c000c0
"Might want to change this, it's pretty ugly, (always made me fix it)
hi Error        guifg=#ffffff guibg=#ff0000
hi Label        guifg=#ff8700
hi StorageClass guifg=#00ff00 gui=NONE
hi Structure    guifg=#00ff00 gui=NONE
hi TypeDef      guifg=#00ff00 gui=NONE
" }}}

" Python specific {{{
"hi pythonExceptions guifg=###### guibg=###### gui=
"hi pythonFunction
hi pythonBuiltin guifg=#00ff00
" }}}

" Vim specific {{{
"hi vimCommentTitle guifg=###### guibg=###### gui=
"hi
"hi
" }}}

" C++ specific {{{
"hi
"hi
"hi
" }}}

" {{{ Completion menus
hi WildMenu  guifg=#000000 guibg=#ffff00

hi Pmenu     guibg=#000080
hi PmenuSel  guibg=#800080
hi PmenuSbar     guibg=#a8a8a8
hi PmenuThumb    guibg=#000000
" }}}

" {{{ Spelling
"NOTE: haven't actually chosen any of this - will have to look at it again
hi spellBad  guibg=#ffd7d7
hi spellCap  guibg=#5fd7ff
hi spellRare     guibg=#ffd7ff
hi spellLocal    guibg=#00ffff
" }}}

" {{{ Aliases
"NOTE: Think easiest to define language specific colours as I only work
"       in three at the moment
"hi link cppSTL          Function
"hi link cppSTLType      Type
"hi link Character      Number
"hi link htmlTag            htmlEndTag
""hi link htmlTagName     htmlTag
"hi link htmlLink       Underlined
"hi link pythonFunction Identifier
"hi link Question       Type
"hi link CursorIM       Cursor
"hi link VisualNOS      Visual
"hi link xmlTag         Identifier
"hi link xmlTagName     Identifier
"hi link shDeref            Identifier
"hi link shVariable     Function
"hi link rubySharpBang  Special
"hi link perlSharpBang  Special
"hi link schemeFunc      Statement
"hi link shSpecialVariables Constant
"hi link bashSpecialVariables Constant
" }}}

" {{{ Tabs (non-gui0
hi TabLine   guifg=#000000 guibg=#c0c0c0 gui=underline
hi TabLineFill   gui=reverse
hi TabLineSel    gui=bold
" }}}
"
"
" Cterm options
if &t_Co==8
  highlight LineNr ctermfg=LightGreen
  highlight CursorColumn cterm=standout ctermfg=Gray ctermbg=NONE
  highlight CursorLine cterm=bold ctermfg=NONE ctermbg=DarkBlue
  highlight Folded cterm=bold ctermfg=blue ctermbg=NONE
  highlight StatusLine cterm=NONE ctermbg=NONE ctermfg=DarkCyan
  highlight StatusLineNC cterm=NONE ctermbg=NONE ctermfg=DarkGray
  highlight Comment      cterm=NONE ctermfg=6
  highlight FoldColumn cterm=NONE ctermfg=Cyan ctermbg=NONE
  highlight String       cterm=NONE        ctermfg=1      ctermbg=NONE
elseif &t_Co==256
  highlight Normal       cterm=NONE        ctermfg=15     ctermbg=NONE
  highlight Comment ctermfg=27 cterm=NONE ctermbg=NONE
  highlight LineNr cterm=NONE ctermfg=DarkGreen
  highlight FoldColumn cterm=NONE ctermfg=Cyan ctermbg=NONE
  highlight Folded       cterm=bold   ctermfg=100    ctermbg=NONE
  highlight CursorColumn cterm=NONE ctermfg=NONE ctermbg=236
  highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=234
  highlight Folded cterm=bold ctermfg=100 ctermbg=NONE
  highlight Search cterm=NONE ctermfg=NONE ctermbg=107
  highlight Pmenu cterm=NONE ctermfg=NONE ctermbg=darkblue
  highlight Pmenusel cterm=NONE ctermfg=NONE ctermbg=darkmagenta
  highlight StatusLine   cterm=NONE   ctermfg=51     ctermbg=NONE
  highlight StatusLineNC cterm=NONE ctermbg=NONE ctermfg=236
  highlight DiffAdd      cterm=NONE        ctermfg=NONE   ctermbg=22
  highlight DiffChange   cterm=NONE        ctermfg=NONE   ctermbg=53
  highlight DiffText     cterm=bold        ctermfg=NONE   ctermbg=23
  highlight DiffDelete   cterm=NONE        ctermfg=58     ctermbg=52
  highlight NonText      cterm=NONE        ctermfg=12     ctermbg=NONE
  highlight VertSplit    cterm=NONE        ctermfg=50     ctermbg=NONE
  highlight ModeMsg      cterm=bold        ctermfg=NONE   ctermbg=NONE
  highlight MoreMsg      cterm=NONE        ctermfg=2      ctermbg=NONE
  highlight Title        cterm=NONE        ctermfg=5      ctermbg=NONE
  highlight WarningMsg   cterm=NONE        ctermfg=1      ctermbg=NONE
  highlight SpecialKey   cterm=NONE        ctermfg=4      ctermbg=NONE
  highlight MatchParen   cterm=NONE        ctermfg=14     ctermbg=NONE
  highlight Underlined   cterm=underline   ctermfg=5      ctermbg=NONE
  highlight Visual       cterm=NONE        ctermfg=NONE   ctermbg=17
  highlight VisualNOS    cterm=bold        ctermfg=NONE   ctermbg=NONE
  highlight IncSearch    cterm=reverse     ctermfg=NONE   ctermbg=NONE
  highlight Ignore       cterm=NONE        ctermfg=15     ctermbg=NONE
  highlight Identifier   cterm=NONE        ctermfg=6      ctermbg=NONE
  highlight PreProc      cterm=NONE        ctermfg=5      ctermbg=NONE
  highlight Constant     cterm=NONE        ctermfg=1      ctermbg=NONE
  highlight String       cterm=NONE        ctermfg=1      ctermbg=NONE
  highlight Function     cterm=NONE        ctermfg=6      ctermbg=NONE
  highlight Statement    cterm=NONE        ctermfg=130    ctermbg=NONE
  highlight Type         cterm=NONE        ctermfg=2      ctermbg=NONE
  highlight Number       cterm=NONE        ctermfg=1      ctermbg=NONE
  highlight Todo         cterm=NONE        ctermfg=0      ctermbg=30
  highlight Special      cterm=NONE        ctermfg=5      ctermbg=NONE
  highlight Error        cterm=NONE        ctermfg=15     ctermbg=9
  highlight Label        cterm=NONE        ctermfg=130    ctermbg=NONE
  highlight StorageClass cterm=NONE        ctermfg=2      ctermbg=NONE
  highlight Structure    cterm=NONE        ctermfg=2      ctermbg=NONE
  highlight TypeDef      cterm=NONE        ctermfg=2      ctermbg=NONE
  highlight WildMenu     cterm=NONE        ctermfg=0      ctermbg=11
  highlight PmenuSbar    cterm=NONE        ctermfg=NONE   ctermbg=248
  highlight PmenuThumb   cterm=NONE        ctermfg=NONE   ctermbg=248
  highlight TabLine      cterm=NONE        ctermfg=NONE   ctermbg=236
  highlight TabLineFill  cterm=NONE        ctermfg=NONE   ctermbg=236
  highlight TabLineSel   cterm=NONE        ctermfg=11     ctermbg=236
endif


" vim: foldmethod=marker
