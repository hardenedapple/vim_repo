" Filetype plugin for all C - type langagues
" should be imported by others.

" add closing of comments when I type the lead
inoremap <buffer> /*  /*<Space><Space>*/<Left><Left><Left>
inoremap <buffer> /*<CR>  /*<CR><CR>/<Esc>kA 

" Assuming my default keymap is in place.
inoremap <buffer> /8  /*<Space><Space>*/<Left><Left><Left>
inoremap <buffer> /8<CR>  /*<CR><CR>/<Esc>kA 

" add opening a block with {<CR>
inoremap <buffer> {<CR>  {<CR>}<Esc>O

" Use double quotes much more than single
lnoremap <buffer> " '
lnoremap <buffer> ' "

set foldexpr=ftplugin_helpers#c_languages#fold_brace()

" The function I've defined works nicely with pretty much all folding styles
" but is slow if there are too many folds above where you're writing.
" Hence, by default have foldmethod as syntax.
set foldmethod=syntax

nnoremap <silent> <LocalLeader>n :call ftplugin_helpers#c_languages#Togglenewlineadd()<CR>
