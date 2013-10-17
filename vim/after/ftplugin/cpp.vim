set foldmethod=syntax

nnoremap [om :set makeprg=g++\ -Wall\ -W\ %\ -o\ %:r<CR>
nnoremap ]om :set makeprg=make<CR>

" Run cscope
nnoremap <F11>  :!cscope -Rb<CR> :cs reset<CR>

" Run ctags (in way for OmniCppComplete)
nnoremap <F12>  :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
