
"gui specific stuff
"change the font used for gui
"set guifont=Nimbus\ Mono\ L\ 10
" set guifont=Terminal\ 10
set guifont=Tamsyn\ 10


"I think I should be able to combine these into one command
"but I don't really mind either way
"remove toobars and menu bar from gvim
set guioptions-=m
set guioptions-=T
"remove left, right and bottom scrollbars
set guioptions-=L
set guioptions-=R
set guioptions-=r
set guioptions-=l
set guioptions-=b
"remove 'vim icon' that I guess is removed already
set guioptions-=i
"don't bother sourcing system menu (option on the menu bar I don't show
set guioptions-=M
"NOTE: have to have this after all the colour declarations, else they'll
"      override the settings
    "colorscheme desert
colorscheme hybrid
    "colorscheme pyte
    "colorscheme pylight
    "colorscheme techras
    
