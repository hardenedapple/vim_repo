" CtrlP plugin
" Change where ctrlp opens the files, what file it looks for and how it
" searches
if !has("gui_running")
    let g:ctrlp_map = "<Nul>"
else
    let g:ctrlp_map = "<C-Space>"
endif

map <Leader>cpt :CtrlPTag<CR>
map <Leader>cpb :CtrlPBufTag<CR>
map <Leader>cpq :CtrlPQuickfix<CR>
map <Leader>cpu :CtrlPUndo<CR>
map <Leader>cpc :CtrlPChange<CR>

let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_open_multiple_files = '2tr'
let g:ctrlp_arg_map = 1
let g:ctrlp_extensions = ['buffertag', 'tag', 'changes', 'line']
"


