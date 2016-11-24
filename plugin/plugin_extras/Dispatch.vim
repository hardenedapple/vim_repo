if index(g:pathogen_disabled, 'dispatch') != -1
  finish
endif

" Add mapping for dispatch
nnoremap <F9> :<C-U>Dispatch<CR>
