if index(g:pathogen_disabled, 'undotree') != -1
  finish
endif

" Undotree plugin
nnoremap <F5> :<C-U>UndotreeToggle<CR>
