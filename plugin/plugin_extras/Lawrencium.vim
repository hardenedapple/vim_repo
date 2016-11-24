if index(g:pathogen_disabled, 'lawrencium') != -1
  finish
endif

" Lawrencium Settings
let g:lawrencium_auto_close_buffers = 1

command! -bar -nargs=* Hgpush execute 'Hg push' <q-args>
command! -bar -nargs=* Hgpull execute 'Hg pull' <q-args>


" Bunch of leader mappings for ease of use
nnoremap <silent> <leader>hd :<C-U>Hgvdiff<CR>
nnoremap <silent> <leader>hp :<C-U>Hgpush<CR>
nnoremap <silent> <leader>hf :<C-U>Hgpull<CR>
nnoremap <silent> <leader>hc :<C-U>Hgcommit<CR>
nnoremap <silent> <leader>hs :<C-U>Hgstatus<CR>
nnoremap <silent> <leader>hg :<C-U>Hglog<CR>
nnoremap <silent> <leader>hv :<C-U>Hglogthis<CR>
nnoremap <silent> <leader>hq :<C-U>Hgqseries<CR>
