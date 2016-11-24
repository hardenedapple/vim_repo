if index(g:pathogen_disabled, 'syntastic') != -1
  finish
endif

" Syntastic plugin
" Get first pylint to check, then if no errors found, check with pep8
" Check for errors on opening
" Use the location list more
" Jump to first error in file
let g:syntastic_python_checkers=["pylint","pep8"]
let g:syntastic_check_on_open=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=0
" Want this when syntastic is passive, not when active
let g:syntastic_auto_jump=0
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons=0
" Get all errors instead of stopping at first error
let g:syntastic_aggregate_errors=1
" Show error in command window
let g:syntastic_echo_current_error=1

" Set syntastic statusline format
let g:syntastic_stl_format='%W{[Warn: %w]}%E{[Err: %e]}'
" Mode of checking
" Leave most files alone - I save a lot
" and pop-ups all the time would get annoying
" Active check ruby and lua - configuration files
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
