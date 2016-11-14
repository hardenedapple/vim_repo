if index(g:pathogen_disabled, 'ctrlp') != -1
  finish
endif

" CtrlP plugin
" Change where ctrlp opens the files, what file it looks for and how it
" searches
if has("gui_running") || has('nvim')
  let g:ctrlp_map = "<C-Space>"
else
  let g:ctrlp_map = "<Nul>"
endif

nnoremap <Leader>cpb :CtrlPBuffer<CR>
nnoremap <Leader>cpc :CtrlPChange<CR>
nnoremap <Leader>cpq :CtrlPQuickfix<CR>
nnoremap <Leader>cpt :CtrlPTag<CR>
nnoremap <Leader>cpu :CtrlPUndo<CR>
nnoremap <Leader>cpm :CtrlPMRU<CR>

let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_open_multiple_files = '2tr'
let g:ctrlp_arg_map = 1
let g:ctrlp_extensions = ['tag', 'changes', 'line']
