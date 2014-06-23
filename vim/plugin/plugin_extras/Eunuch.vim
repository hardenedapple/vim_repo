" Mappings for Eunuch.vim and a little file handling function
nnoremap <leader>fr :Unlink<CR>
nnoremap <leader>fm :Rename 
nnoremap <leader>ff :Find 

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

com! DiffSaved call s:DiffWithSaved()

nnoremap <leader>fd :DiffSaved<CR>
