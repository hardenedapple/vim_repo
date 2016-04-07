if index(g:pathogen_disabled, 'easygrep') != -1
  finish
endif

let g:EasyGrepMode = 2
let g:EasyGrepCommand = 1
let g:EasyGrepFilesToExclude = ".svn,.git,.hg"
let g:EasyGrepJumpToMatch = 0
let g:EasyGrepReplaceAllPerFile = 1

" Have to use nmap but currently don't know why.
nmap g<RightMouse> <LeftMouse><Plug>EgMapGrepCurrentWord_v
