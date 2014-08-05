" Lawrencium Settings
let g:lawrencium_auto_close_buffers = 1

command! -bar -nargs=* Hgpush execute 'Hg push' <q-args>
command! -bar -nargs=* Hgpull execute 'Hg pull' <q-args>


" Bunch of leader mappings for ease of use
nnoremap <silent> <leader>hd :Hgvdiff<CR>
nnoremap <silent> <leader>hp :Hgpush<CR>
nnoremap <silent> <leader>hf :Hgpull<CR>
nnoremap <silent> <leader>hc :Hgcommit<CR>
nnoremap <silent> <leader>hs :Hgstatus<CR>
nnoremap <silent> <leader>hg :Hglog<CR>
nnoremap <silent> <leader>hv :Hglogthis<CR>
nnoremap <silent> <leader>hq :Hgqseries<CR>
