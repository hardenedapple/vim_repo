if index(g:pathogen_disabled, 'syntastic') != -1
  finish
endif

let g:syntastic_python_checkers=["pylint","pep8"]
let g:syntastic_check_on_open=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_auto_jump=1
let g:syntastic_enable_signs=0
let g:syntastic_enable_balloons=0
let g:syntastic_aggregate_errors=1
let g:syntastic_echo_current_error=0

let g:syntastic_stl_format=''
" Mode of checking -- don't do anything unless I ask
" passive => only check when call ':SyntasticCheck'
" active  => check when save and load file
let g:syntastic_mode_map = {
      \ 'mode': 'passive',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': []
      \ }
"
" Map <leader>ok to check the file
nnoremap <leader>ok :<C-U>SyntasticCheck<CR>
nnoremap <leader>rk :<C-U>SyntasticReset<CR>

" I don't like errors highlighted.
highlight SyntasticError ctermbg=NONE guibg=NONE
highlight SyntasticWarning ctermbg=NONE guibg=NONE
