if index(g:pathogen_disabled, 'gundo') != -1
  finish
endif

" Gundo plugin
nnoremap <F5> :<C-U>GundoToggle<CR>
