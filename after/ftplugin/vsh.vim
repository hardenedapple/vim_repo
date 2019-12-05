" Shell commands often use - and rarely use _
lnoremap <buffer> - -
lnoremap <buffer> _ _

" On the other hand ... I reasonably often run interpreters in the vsh buffer,
" when this is the case I'd like to change the mappings for that language.
nnoremap <silent><buffer> <localleader>u :call helpers#toggle_underscore()<CR>
nnoremap <silent><buffer> <localleader>q :call helpers#toggle_colon()<CR>

" When completing filenames in things like `dd if=...` I want to remove the '='
" sign from isfname.
setlocal isfname-==

" Want `tabstop` to be 8 for output, but want 4 for when typing commands.
setlocal softtabstop=4

" Really don't want spaces turned into tabs, as this ends up replacing the
" spaces after a prompt with a tab hence making that line not match the prompt
" regex any more.
setlocal expandtab
