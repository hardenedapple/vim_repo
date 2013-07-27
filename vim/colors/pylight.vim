" Vim color file
"
" Modified from github color scheme 
"          http://www.vim.org/scripts/script.php?script_id=2855
"
"Taking elements of bitbuckets syntax highlighting
"
" TODO: Change Visual highlight
"       Check typedef colour
"
" NOTE: So far managed to make it nice for python
"       Will next make it nice for cpp
"       Then for vimscript
"       Then make it as general as possible.
"
" NOTE: As at the moment I only use the three languages
"       I may as well fix any problems that occur in one but not
"       others directly (i.e. override any aliases that I don't like.

hi clear

set background=light
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="pylight"

"hi Normal       guifg=#000000 guibg=#F0F0F0
hi Normal       guifg=#000000 guibg=#F8F8FF

" {{{ Cursor
hi Cursor		guibg=#444454 guifg=#F8F8FF
hi CursorLine	guibg=#E4E4E4
"hi CursorLine	guibg=#D8D8DD
hi CursorColumn	guibg=#E8E8EE
" }}}

" {{{ Diff
hi DiffAdd         guifg=#003300 guibg=#DDFFDD gui=none
hi DiffChange                    guibg=#ececec gui=none
hi DiffText        guifg=#000033 guibg=#DDDDFF gui=none
hi DiffDelete      guifg=#DDCCCC guibg=#FFDDDD gui=none
" }}}

" {{{ Folding / Line Numbering / Status Lines
hi Folded		guibg=#ECECEC guifg=#808080 gui=bold
hi vimFold		guibg=#ECECEC guifg=#808080 gui=bold
hi FoldColumn	guibg=#ECECEC guifg=#808080 gui=bold

hi LineNr		guifg=#959595 guibg=#ECECEC gui=NONE
hi NonText		guifg=#808080 guibg=#ECECEC
hi Folded		guifg=#808080 guibg=#ECECEC gui=bold
hi FoldeColumn  guifg=#808080 guibg=#ECECEC gui=bold

hi VertSplit	guibg=#bbbbbb guifg=#bbbbbb gui=none
hi StatusLine   guibg=#bbbbbb guifg=#404040 gui=bold
hi StatusLineNC guibg=#d4d4d4 guifg=#404040 gui=italic
" }}}

" {{{ Misc
hi ModeMsg		guifg=#990000
hi MoreMsg		guifg=#990000

hi Title		guifg=#ef5939
hi WarningMsg	guifg=#ef5939
hi SpecialKey   guifg=#177F80 gui=italic

hi MatchParen	guibg=#cdcdfd guifg=#000000
hi Underlined	guifg=#000000 gui=underline
hi Directory	guifg=#990000
" }}}

" {{{ Search, Visual, etc
"not confident about this change
"hi Visual		guifg=#FFFFFF guibg=#3465a4 gui=none
hi Visual       guifg=NONE    guibg=#aaddff gui=NONE
hi VisualNOS    guifg=#FFFFFF guibg=#204a87 gui=NONE
hi IncSearch	guibg=#cdcdfd guifg=NONE gui=italic
hi Search		guibg=#cdcdfd guifg=NONE gui=italic
"hi IncSearch	guibg=#cdcdfd guifg=#000000 gui=italic
"hi Search		guibg=#cdcdfd guifg=#000000 gui=italic
" }}}

" {{{ Syntax groups
"not sure what Ignore does at the moment - remoember for later.
hi Ignore		guifg=#808080
hi Identifier	guifg=#af0000
" change things like bold, italic etc in vim
" generic preprocessor (#if #else #define #include)
" subclasses of Include, Define, Precondit
hi PreProc		guifg=#af0000 gui=bold
hi Include      guifg=#87005F gui=bold
hi Comment		guifg=#999988 gui=italic
hi Constant		guifg=#177F80 gui=none
"change this to a teal-like colour
hi String		guifg=#D7AF00
"hi Function		guifg=#000000 gui=NONE
hi Function		guifg=#af0000 gui=NONE
"Change this to change things like def in python
hi Statement	guifg=#080887 gui=NONE
"Change type to change all these guifg and Comment String etc words
hi Type			guifg=#080887 gui=NONE
hi Number		guifg=#1C9898
"metacharacters e.g. \n
hi Special		guifg=#ff5f5f gui=bold
"hi rubySymbol   guifg=#960B73
"Change this
hi Error        guibg=#f8f8ff guifg=#ff1100 gui=undercurl
hi Todo         guibg=#f8f8ff guifg=#585858 gui=underline
hi Label        guifg=#000000 gui=bold
"change things like 'const' in cpp
hi StorageClass guifg=#080887 gui=NONE
" Change this (assuming this defines the colour of the using namespace bit)
"Structure defined things like AssertionError in python
hi Structure    guifg=#008700
hi Operator     guifg=#87005F gui=NONE
"may want to change this - see later
hi TypeDef      guifg=#000000 gui=bold
" }}}

" Python specific {{{
hi pythonExceptions guifg=#af0000 gui=NONE
hi pythonFunction guifg=#af0000 gui=NONE
hi pythonBuiltin guifg=#008700 gui=italic

"}}}

" Vim specific {{{
hi vimCommentTitle guifg=#999988 gui=bold
" }}}

" C++ specific {{{
"want something 
hi cppType guifg=#ff0087
"Things like int, void, double much more important
"hence need a more distinguishing colour.
"NOTE: cppOperators and cppTypes often together.
"Have a look at $VIMRUNTIME/syntax/cpp.vim
"maybe add some definitions in there.
" }}}

" {{{ Completion menus
hi WildMenu     guifg=#7fbdff guibg=#425c78 gui=none

hi Pmenu        guibg=#808080 guifg=#ffffff gui=bold
hi PmenuSel     guibg=#cdcdfd guifg=#000000 gui=italic
hi PmenuSbar    guibg=#000000 guifg=#444444
hi PmenuThumb   guibg=#aaaaaa guifg=#aaaaaa
" }}}

" {{{ Spelling
hi spellBad     guisp=#fcaf3e
hi spellCap     guisp=#73d216
hi spellRare    guisp=#fcaf3e
hi spellLocal   guisp=#729fcf
" }}}

" {{{ Aliases
hi link cppSTL          Function
hi link cppSTLType      Type
hi link Character		Number
hi link htmlTag			htmlEndTag
"hi link htmlTagName     htmlTag
hi link htmlLink		Underlined
"hi link pythonFunction	Identifier
hi link Question		Type
hi link CursorIM		Cursor
hi link VisualNOS		Visual
hi link xmlTag			Identifier
hi link xmlTagName		Identifier
hi link shDeref			Identifier
hi link shVariable		Function
hi link rubySharpBang	Special
hi link perlSharpBang	Special
hi link schemeFunc      Statement
"hi link shSpecialVariables Constant
"hi link bashSpecialVariables Constant
" }}}

" {{{ Tabs (non-gui0
hi TabLine		guifg=#404040 guibg=#dddddd gui=none
hi TabLineFill	guifg=#404040 guibg=#dddddd gui=none
hi TabLineSel	guifg=#404040 gui=bold
" }}}
"
" vim: sw=4 ts=4 foldmethod=marker
