" add a simple toggle for test scripts
nnoremap <buffer> [om :set makeprg=gcc\ -Wall\ -W\ -Werror\ -g\ %\ -o\ %:r<CR>
nnoremap <buffer> ]om :set makeprg=make<CR>

" Run cscope
nnoremap <F11>  :!cscope -Rb<CR> :cs reset<CR>
