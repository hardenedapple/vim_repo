if index(g:pathogen_disabled, 'gitv') != -1
  finish
endif

" If I didn't already have an autocommand removing fugitive buffers would
" probably  want
" let g:Gitv_WipeAllOnClose = 1

nnoremap <silent> <leader>gg :<C-U>Gitv --all<CR>
nnoremap <silent> <leader>gv :<C-U>Gitv! --all<CR>
vnoremap <silent> <leader>gv :<C-U>Gitv! --all<CR>
