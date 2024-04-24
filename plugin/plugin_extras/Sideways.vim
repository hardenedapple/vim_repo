if index(g:pathogen_disabled, 'sideways') != -1
  finish
endif

" Sideways mappings
nnoremap <silent> <leader>ah <cmd>SidewaysLeft<CR>
nnoremap <silent> <leader>al <cmd>SidewaysRight<CR>

" Text object of an argument
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI
