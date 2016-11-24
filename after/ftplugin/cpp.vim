" Add /usr/include/ to the path variable
set path^=/usr/include

" add a simple toggle for test scripts
nnoremap <buffer> [om :<C-U>set makeprg=g++\ -Wall\ -W\ -Werror\ -g\ %\ -o\ %:r<CR>
nnoremap <buffer> ]om :<C-U>set makeprg=make<CR>
