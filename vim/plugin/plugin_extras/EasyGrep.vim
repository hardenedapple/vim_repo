if index(g:pathogen_disabled, 'easygrep') != -1
  finish
endif

let EasyGrepMode = 2
let EasyGrepCommand = 1
let EasyGrepFilesToExclude = ".svn,.git,.hg"
let EasyGrepJumpToMatch = 0
let EasyGrepReplaceAllPerFile = 1
