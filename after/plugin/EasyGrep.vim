if index(g:pathogen_disabled, 'easygrep') != -1
  finish
endif

" Have to use nmap but currently don't know why.
nmap g<RightMouse> <LeftMouse><Plug>EgMapGrepCurrentWord_v
