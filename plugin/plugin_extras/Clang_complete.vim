if index(g:pathogen_disabled, 'clang_complete') != -1
  finish
endif

" clang_complete options - using ultisnips
let g:clang_auto_select=1
let g:clang_complete_auto=1
let g:clang_complete_copen=0
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=0
let g:clang_snippets=1
let g:clang_snippets_engine="ultisnips"
let g:clang_conceal_snippets=1
let g:clang_trailing_placeholder=1
let g:clang_use_library=1
let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
" Have a look at replacing c-support with this and ultisnips
let g:clang_complete_patterns=0
let g:clang_jumpto_declaration_key="<C-]>"
" Just use C-O, and retain C-T for use with cscope
let g:clang_jumpto_back_key=""
let g:clang_user_options="|| exit 0"
autocmd FileType c,cpp setlocal concealcursor+=iv
" Map ctrl-space to the completion
if has('gui_running')
  autocmd FileType c,cpp inoremap <silent> <buffer> <C-Space> <C-X><C-U>
else
  autocmd FileType c,cpp inoremap <silent> <buffer> <C-@> <C-X><C-U>
endif
