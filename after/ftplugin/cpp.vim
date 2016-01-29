" add a simple toggle for test scripts
nnoremap <buffer> [om :set makeprg=g++\ -Wall\ -W\ -Werror\ -g\ %\ -o\ %:r<CR>
nnoremap <buffer> ]om :set makeprg=make<CR>
