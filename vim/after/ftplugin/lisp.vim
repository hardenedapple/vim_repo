" I like the idea behind Tim Pope's vim-sexp-mappings-for-regular-people.
" I personally think the WORD motions are more useful than the word motions.
" Hence I'll remap them - After this and vim-sexp-mappings-for-regular-people
" have run,  W should go across a sexp and w should move over a WORD.

if !exists("g:after_sexp_loaded") || exists("g:after_sexp_mappings")
    echom "Did not load convert_motions.vim"
  finish
endif
let g:after_sexp_mappings = 1

nnoremap <buffer> b B
nnoremap <buffer> w W
nnoremap <buffer> e E
nnoremap <buffer> ge gE
xnoremap <buffer> b B
xnoremap <buffer> w W
xnoremap <buffer> e E
xnoremap <buffer> ge gE
onoremap <buffer> b B
onoremap <buffer> w W
onoremap <buffer> e E
onoremap <buffer> ge gE
