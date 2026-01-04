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

" Originally I had #ffffff, that is just too bright.  Especially for low-light
" environments (which is where I like this colorscheme).
hi Normal    guifg=#c0c0c0 guibg=#000000

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
hi FoldColumn    guifg=#00b0b0 guibg=NONE gui=NONE

hi LineNr     guifg=#008000  guibg=NONE gui=NONE
hi NonText   guifg=#858585 guibg=NONE gui=NONE

hi VertSplit     guifg=#00b0d7 guibg=NONE gui=NONE
hi StatusLine    guifg=#00b0b0 guibg=NONE gui=NONE
hi StatusLineNC  guifg=#707070 guibg=NONE gui=NONE

hi TabLine  guifg=#909090 guibg=#282828 gui=NONE
hi TabLineFill  guifg=#909090 guibg=#282828 gui=NONE
" }}}


" {{{ Misc
hi ModeMsg   gui=bold
hi MoreMsg   guifg=#008000

hi Title     guifg=#a020a0
hi WarningMsg    guifg=#800000
hi SpecialKey    guifg=#3030ff

hi MatchParen    guibg=#00b0b0 ctermbg=grey
hi Underlined    guifg=#800080 gui=underline
hi Directory     guifg=#5050e0
" }}}

" {{{ Search, Visual, etc
"NOTE: I don't actually like the Visual defaults, will want to change these
hi Visual    guibg=#00003f
hi VisualNOS     gui=bold
"Not sure what this is - will have to find out
hi IncSearch     gui=reverse
hi Search    guibg=#303030 guifg=NONE
" }}}

" {{{ Syntax groups
hi Ignore       guifg=#b0b0b0
hi Identifier   guifg=#00b0b0
hi PreProc      guifg=#c000c0
hi Comment      guifg=#5f5fff gui=italic
hi Constant     guifg=#005faf
hi String       guifg=#f03030
hi Function     guifg=#00b0b0
hi Statement    guifg=#b08700 gui=NONE
hi Type         guifg=#00b000  gui=NONE
hi Number       guifg=#f03030
" don't like this - want to improve
hi Todo  guifg=#000000 guibg=#b0b000
hi Special   guifg=#c000c0
"Might want to change this, it's pretty ugly, (always made me fix it)
hi Error        guifg=#b0b0b0 guibg=#b00000
hi Label        guifg=#b08700
hi StorageClass guifg=#00b000 gui=NONE
hi Structure    guifg=#00b000 gui=NONE
hi TypeDef      guifg=#00b000 gui=NONE
" }}}

" Python specific {{{
"hi pythonExceptions guifg=###### guibg=###### gui=
"hi pythonFunction
hi pythonBuiltin guifg=#00b000
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
hi WildMenu  guifg=#000000 guibg=#b0b000

hi Pmenu     guibg=#000080
hi PmenuSel  guibg=#800080
hi PmenuSbar     guibg=#a8a8a8
hi PmenuThumb    guibg=#000000
" }}}

" {{{ Spelling
"NOTE: haven't actually chosen any of this - will have to look at it again
hi spellBad  guibg=#b0d7d7
hi spellCap  guibg=#5fd7b0
hi spellRare     guibg=#b0d7b0
hi spellLocal    guibg=#00b0b0
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

" {{{ Treesitter links
if has('nvim')
  " Not done much work here, just the majority of text in programming buffers.
  " Seems like for some reason the `syntax reset` at the top of this file doesn't
  " clear the @variable syntax group, so we do it manually here.
  highlight clear @variable
  highlight link @variable Normal
  highlight link @variable.parameter Normal
  highlight link @variable.member Normal
  highlight link @number Number
endif
" }}}
"
"
" Cterm options
if &t_Co==8
  highlight LineNr       cterm=NONE          ctermbg=NONE      ctermfg=LightGreen
  highlight CursorColumn cterm=standout      ctermbg=NONE      ctermfg=Gray
  highlight CursorLine   cterm=bold          ctermbg=DarkBlue  ctermfg=NONE
  highlight Folded       cterm=bold          ctermbg=NONE      ctermfg=blue
  highlight StatusLine   cterm=NONE          ctermbg=NONE      ctermfg=DarkCyan
  highlight StatusLineNC cterm=NONE          ctermbg=NONE      ctermfg=Gray
  highlight Comment      cterm=NONE          ctermbg=NONE      ctermfg=6
  highlight FoldColumn   cterm=NONE          ctermbg=NONE      ctermfg=Cyan
  highlight String       cterm=NONE          ctermbg=NONE      ctermfg=1
elseif &t_Co==256
  highlight Normal       cterm=NONE       ctermbg=NONE         ctermfg=15
  highlight Comment      cterm=NONE       ctermbg=NONE         ctermfg=27
  highlight LineNr       cterm=NONE       ctermfg=DarkGreen
  highlight FoldColumn   cterm=NONE       ctermbg=NONE         ctermfg=Cyan
  highlight Folded       cterm=bold       ctermbg=NONE         ctermfg=100
  highlight CursorColumn cterm=NONE       ctermbg=236          ctermfg=NONE
  highlight CursorLine   cterm=NONE       ctermbg=234          ctermfg=NONE
  highlight Folded       cterm=bold       ctermbg=NONE         ctermfg=100
  highlight Search       cterm=NONE       ctermbg=235          ctermfg=NONE
  highlight Pmenu        cterm=NONE       ctermbg=darkblue     ctermfg=NONE
  highlight Pmenusel     cterm=NONE       ctermbg=darkmagenta  ctermfg=NONE
  highlight StatusLine   cterm=NONE       ctermbg=NONE         ctermfg=51
  highlight StatusLineNC cterm=NONE       ctermbg=NONE         ctermfg=Gray
  highlight TabLine      cterm=NONE       ctermbg=DarkGray     ctermfg=NONE
  highlight TabLineFill  cterm=NONE       ctermbg=DarkGray     ctermfg=NONE
  highlight DiffAdd      cterm=NONE       ctermbg=22           ctermfg=NONE
  highlight DiffChange   cterm=NONE       ctermbg=53           ctermfg=NONE
  highlight DiffText     cterm=bold       ctermbg=23           ctermfg=NONE
  highlight DiffDelete   cterm=NONE       ctermbg=52           ctermfg=58
  highlight NonText      cterm=NONE       ctermbg=NONE         ctermfg=12
  highlight VertSplit    cterm=NONE       ctermbg=NONE         ctermfg=50
  highlight ModeMsg      cterm=bold       ctermbg=NONE         ctermfg=NONE
  highlight MoreMsg      cterm=NONE       ctermbg=NONE         ctermfg=2
  highlight Title        cterm=NONE       ctermbg=NONE         ctermfg=5
  highlight WarningMsg   cterm=NONE       ctermbg=NONE         ctermfg=1
  highlight SpecialKey   cterm=NONE       ctermbg=NONE         ctermfg=4
  highlight MatchParen   cterm=NONE       ctermbg=NONE         ctermfg=14
  highlight Underlined   cterm=underline  ctermbg=NONE         ctermfg=5
  highlight Visual       cterm=NONE       ctermbg=17           ctermfg=NONE
  highlight VisualNOS    cterm=bold       ctermbg=NONE         ctermfg=NONE
  highlight IncSearch    cterm=reverse    ctermbg=NONE         ctermfg=NONE
  highlight Ignore       cterm=NONE       ctermbg=NONE         ctermfg=15
  highlight Identifier   cterm=NONE       ctermbg=NONE         ctermfg=6
  highlight PreProc      cterm=NONE       ctermbg=NONE         ctermfg=5
  highlight Constant     cterm=NONE       ctermbg=NONE         ctermfg=1
  highlight String       cterm=NONE       ctermbg=NONE         ctermfg=1
  highlight Function     cterm=NONE       ctermbg=NONE         ctermfg=6
  highlight Statement    cterm=NONE       ctermbg=NONE         ctermfg=130
  highlight Type         cterm=NONE       ctermbg=NONE         ctermfg=2
  highlight Number       cterm=NONE       ctermbg=NONE         ctermfg=1
  highlight Todo         cterm=NONE       ctermbg=30           ctermfg=0
  highlight Special      cterm=NONE       ctermbg=NONE         ctermfg=5
  highlight Error        cterm=NONE       ctermbg=9            ctermfg=15
  highlight Label        cterm=NONE       ctermbg=NONE         ctermfg=130
  highlight StorageClass cterm=NONE       ctermbg=NONE         ctermfg=2
  highlight Structure    cterm=NONE       ctermbg=NONE         ctermfg=2
  highlight TypeDef      cterm=NONE       ctermbg=NONE         ctermfg=2
  highlight WildMenu     cterm=NONE       ctermbg=11           ctermfg=0
  highlight PmenuSbar    cterm=NONE       ctermbg=248          ctermfg=NONE
  highlight PmenuThumb   cterm=NONE       ctermbg=248          ctermfg=NONE
  highlight TabLine      cterm=NONE       ctermbg=236          ctermfg=NONE
  highlight TabLineFill  cterm=NONE       ctermbg=236          ctermfg=NONE
  highlight TabLineSel   cterm=NONE       ctermbg=236          ctermfg=11
	if has('nvim')
		highlight NormalFloat ctermbg=235
	endif
endif


" vim: foldmethod=marker
