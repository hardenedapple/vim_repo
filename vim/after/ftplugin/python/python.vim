" set foldmethod=indent
setlocal comments=:#
setlocal commentstring=#%s
setlocal textwidth=79

setlocal fo+=crot
setlocal define=^\s*\\(def\\\\|class\\)

" Don't use semicolon very often in python
inoremap <buffer> ; :
inoremap <buffer> : ;

" Macro to go to and change the next occurance of TODO
" require setreg  -  see
" https://groups.google.com/forum/?_escaped_fragment_=topic/vim_use/-pbK15zfqts#!topic/vim_use/-pbK15zfqts
call setreg('d', '/TODOc//e', 'c')

if exists(':Tabularize')
    AddTabularPattern!  docstring_varnames /:\zs /l0c0l0
endif
