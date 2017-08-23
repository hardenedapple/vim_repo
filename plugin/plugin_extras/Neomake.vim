if index(g:pathogen_disabled, 'neomake') != -1
  finish
endif

" Add mapping for dispatch
nnoremap <F9> :<C-U>Neomake!<CR>
let g:neomake_place_signs = 0
let g:neomake_highlight_columns = 0
let g:neomake_open_list = 2

augroup my_neomake_hooks
  autocmd!
  autocmd User NeomakeFinished nested call helpers#open_list_unobtrusively('', g:neomake_hook_context.jobinfo.file_mode ? 'lopen' : 'copen')
augroup END
