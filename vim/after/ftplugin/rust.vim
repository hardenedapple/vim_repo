runtime! ftplugin/c_languages.vim

" add a simple toggle for test scripts
nnoremap <buffer> [om :set makeprg=rustc\ -g\ %\ -o\ %:r<CR>
nnoremap <buffer> ]om :set makeprg=make<CR>
