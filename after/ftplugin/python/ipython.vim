if index(g:pathogen_disabled, 'vim-ipython') != -1
  finish
endif

" " Add some mappings for vim ipython
map  <buffer> <silent> <LocalLeader>a <Plug>(IPython-RunFile)
map  <buffer> <silent> <LocalLeader>. <Plug>(IPython-RunLineAsTopLevel)
xmap <buffer> <silent> <LocalLeader>. <Plug>(IPython-RunLineAsTopLevel)
xmap <buffer> <silent> <LocalLeader>o <Plug>(IPython-RunLinesAsTopLevel)

map  <buffer> <silent> <LocalLeader>> <Plug>(IPython-RunLine)
xmap <buffer> <silent> <LocalLeader>> <Plug>(IPython-RunLine)
map  <buffer> <silent> <LocalLeader>O <Plug>(IPython-RunLines)
xmap <buffer> <silent> <LocalLeader>O <Plug>(IPython-RunLines)

map  <buffer> <silent> <LocalLeader>i <Plug>(IPython-OpenPyDoc)
map  <buffer> <silent> <LocalLeader>u <Plug>(IPython-UpdateShell)

nmap <buffer> <silent> <LocalLeader>o :set operatorfunc=PyrunThis<CR>g@

" "" Example of how to quickly clear the current plot with a keystroke
" "map  <buffer> <silent> <F12>          <Plug>(IPython-PlotClearCurrent)
" "" Example of how to quickly close all figures with a keystroke
" "map  <buffer> <silent> <F11>          <Plug>(IPython-PlotCloseAll)

