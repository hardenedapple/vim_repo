if index(g:pathogen_disabled, 'ctrlp-funky') != -1
  finish
endif

let g:ctrlp_funky_syntax_highlight = 1

nnoremap <Leader>cpf :<C-U>CtrlPFunky<CR>

let g:ctrlp_extensions = reverse(add(reverse(g:ctrlp_extensions), 'funky'))
