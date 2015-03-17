if index(g:pathogen_disabled, 'neomake') != -1
  finish
endif

" Add mapping for dispatch
nnoremap <F9> :Neomake<CR>
