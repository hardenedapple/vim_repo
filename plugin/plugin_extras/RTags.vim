if index(g:pathogen_disabled, 'rtags') != -1
  finish
endif

let g:rtagsUseDefaultMappings = 1
let g:rtagsUseLocationList = 0
" Only define variables in C++ buffers, not in C or objective-C etc.
let g:rtagsActiveFiletypes = ['cpp']

