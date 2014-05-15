" add a simple toggle for test scripts
nnoremap [om :set makeprg=g++\ -Wall\ -W\ -Werror\ -g\ %\ -o\ %:r<CR>
nnoremap ]om :set makeprg=make<CR>

" Run cscope
nnoremap <F11>  :!cscope -Rb<CR> :cs reset<CR>
