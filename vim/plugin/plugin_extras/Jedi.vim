if index(g:pathogen_disabled, 'jedi') != -1
  finish
endif

let g:jedi#auto_initialization = 1 " Maps C-Space to completion.
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 0
" Show the signature while entering a function
" Breaks undo history so disable by default
let g:jedi#show_call_signatures = 0
" let g:jedi#use_splits_not_buffers = "right"
" let g:jedi#force_py_version = 3
