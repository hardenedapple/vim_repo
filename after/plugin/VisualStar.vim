if index(g:pathogen_disabled, 'visualstar') != -1
  finish
endif
" Don't like this mapping -- I want to allow Shift mouse keys to pass through
" to xterm no matter what mode I'm in.
unmap <S-LeftMouse>
