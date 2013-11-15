" Jedi vim
let g:jedi#use_tabs_not_buffers=0
let g:jedi#use_splits_not_buffers="right"
" Don't want completeopt overridden - and already have C-c mapped to ESC
let g:jedi#auto_vim_configuration=0
" allow enabling and disabling jedi call signatures
autocmd FileType python nnoremap [oj  :let g:jedi#show_call_signatures=1<CR>
autocmd FileType python nnoremap ]oj  :let g:jedi#show_call_signatures=0<CR>
" This can be put in a modeline, or ftplugin file, but I don't want to
" split up plugin options.
nnoremap [op  :set completeopt+=preview<CR>
nnoremap ]op  :set completeopt-=preview<CR>
"


