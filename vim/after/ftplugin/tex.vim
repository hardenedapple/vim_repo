"Add the menubar (to use latexsuite)
set guioptions+=m

"Probable only work on writing at work (on big screen)
set textwidth=125

"remove conflicts from opening menu tabs
setlocal winaltkeys=no

"Make automatic creation pdf from command \"make\" instead of dvi
let g:Tex_DefaultTargetFormat='pdf'

"Turn off the makefile setting - in case that's causing the problem
let g:Tex_UseMakefile=0

"Change the font to one better for tex
set guifont=ProggyCleanTT\ 12
if has('gui_running')
    colorscheme autumn
endif
