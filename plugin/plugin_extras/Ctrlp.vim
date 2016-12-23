if index(g:pathogen_disabled, 'ctrlp') != -1
  finish
endif

" I can't tell for certain what key will come when pressing Ctrl-Space.
" On the same version of neovim I get two different values depending on which
" laptop I'm running the program on -- I don't know where the difference comes
" from.
" Hence, just map CtrlP to <Nul> and have any occurance of C-Space converted to
" that.
nmap <C-Space> <Nul>
let g:ctrlp_map = "<Nul>"

nnoremap <Leader>cpb :<C-U>CtrlPBuffer<CR>
nnoremap <Leader>cpc :<C-U>CtrlPChange<CR>
nnoremap <Leader>cpq :<C-U>CtrlPQuickfix<CR>
nnoremap <Leader>cpt :<C-U>CtrlPTag<CR>
nnoremap <Leader>cpu :<C-U>CtrlPUndo<CR>
nnoremap <Leader>cpm :<C-U>CtrlPMRU<CR>

let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_open_multiple_files = '2tr'
let g:ctrlp_arg_map = 1
let g:ctrlp_extensions = ['tag', 'changes', 'line']
