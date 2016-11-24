if index(g:pathogen_disabled, 'easygrep') != -1
  finish
endif

nmap g<RightMouse> <LeftMouse><Plug>EgMapGrepCurrentWord_v
