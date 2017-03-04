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

setlocal foldexpr=ftplugin_helpers#c_languages#fold_brace()
" Only used for adding markers for folding, and the vim-commentary plugin.
" I find this value more useful for the plugin.
setlocal commentstring=//\ %s

" The function I've defined works nicely with pretty much all folding styles
" but is slow if there are too many folds above where you're writing.
" Hence, by default have foldmethod as syntax.
setlocal foldmethod=syntax

nnoremap <buffer> <silent> <LocalLeader>n :<C-U>call ftplugin_helpers#c_languages#Togglenewlineadd()<CR>
