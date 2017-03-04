" Shell commands often use - and rarely use _
lnoremap <buffer> - -
lnoremap <buffer> _ _

nnoremap <silent><buffer> <localleader>u :call helpers#toggle_underscore()<CR>
