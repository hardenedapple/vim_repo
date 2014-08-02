" " Add some mappings for vim ipython
map  <buffer> <silent> <LocalLeader>c <Plug>(IPython-RunFile)
map  <buffer> <silent> <LocalLeader>l <Plug>(IPython-RunLineAsTopLevel)
xmap <buffer> <silent> <LocalLeader>l <Plug>(IPython-RunLineAsTopLevel)
map  <buffer> <silent> <LocalLeader>r <Plug>(IPython-RunLinesAsTopLevel)
xmap <buffer> <silent> <LocalLeader>r <Plug>(IPython-RunLinesAsTopLevel)

map  <buffer> <silent> <LocalLeader>L <Plug>(IPython-RunLine)
xmap <buffer> <silent> <LocalLeader>L <Plug>(IPython-RunLine)
map  <buffer> <silent> <LocalLeader>R <Plug>(IPython-RunLines)
xmap <buffer> <silent> <LocalLeader>R <Plug>(IPython-RunLines)

map  <buffer> <silent> <LocalLeader>i <Plug>(IPython-OpenPyDoc)
map  <buffer> <silent> <LocalLeader>u <Plug>(IPython-UpdateShell)


" "" Example of how to quickly clear the current plot with a keystroke
" "map  <buffer> <silent> <F12>          <Plug>(IPython-PlotClearCurrent)
" "" Example of how to quickly close all figures with a keystroke
" "map  <buffer> <silent> <F11>          <Plug>(IPython-PlotCloseAll)

