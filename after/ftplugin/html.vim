setlocal tabstop=2
setlocal shiftwidth=2

" TODO Create a function that moves me out of the current tag.
" This mapping is good enough most of the time, but it has a whole bunch of
" side-effects, and missing edge cases.
"
" Mapping to g:UltiSnipsJumpForwardTrigger so that pressing that key jumps out
" of the tag whether I've defined the snippet to do so or not.
if exists('g:UltiSnipsJumpForwardTrigger')
  execute "inoremap " . g:UltiSnipsJumpForwardTrigger . " <esc>vitf><esc>a"
else
  inoremap <C-j> <esc>vitf><esc>a
endif
