" Shell commands often use - and rarely use _
lnoremap <buffer> - -
lnoremap <buffer> _ _

nnoremap <silent><buffer> <localleader>u :call helpers#toggle_underscore()<CR>

" When completing filenames in things like `dd if=...` I want to remove the '='
" sign from isfname.
setlocal isfname-==
