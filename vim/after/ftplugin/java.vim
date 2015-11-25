" add a simple toggle for test scripts
nnoremap <buffer> [om :set makeprg=javac\ %<CR>
nnoremap <buffer> ]om :set makeprg=make<CR>

let general_plug = expand('<sfile>:p:h') . "/c_languages.vim"
exec "source " . general_plug

" Overwrite the foldmethod from c_languages.vim
set foldmethod=syntax
