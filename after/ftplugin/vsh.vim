" I reasonably often run interpreters in the vsh buffer.  Especially with
" python, having shift for colons is tedious enough to have a special-case.
" When running an interpreter in one window and editing a python file in the
" other things are easier if both have the modification between colon and
" semicolon applied.
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
