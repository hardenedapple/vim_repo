" If I didn't already have an autocommand removing fugitive buffers would
" probably  want
" let g:Gitv_WipeAllOnClose = 1

nnoremap <silent> <leader>gg :Gitv --all<CR>
nnoremap <silent> <leader>gv :Gitv! --all<CR>
vnoremap <silent> <leader>gv :Gitv! --all<CR>
