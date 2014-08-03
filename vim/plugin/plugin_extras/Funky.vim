let g:ctrlp_funky_syntax_highlight = 1

nnoremap <Leader>cpf :CtrlPFunky<CR>

let temp_extensions = reverse(g:ctrlp_extensions)
call add(temp_extensions, 'funky')
let g:ctrlp_extensions = reverse(temp_extensions)
