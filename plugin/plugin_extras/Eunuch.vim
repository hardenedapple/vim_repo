if index(g:pathogen_disabled, 'eunuch') != -1
  finish
endif

" Mappings for Eunuch.vim and a little file handling function
nnoremap <leader>fr :Unlink<CR>
nnoremap <leader>fm :Rename 
nnoremap <leader>ff :Find 

function s:DiffWithSaved()
  let filetype = &ft
  let diffline = line('.')
  diffthis
  vertical new
  read ++edit #
  0delete_
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  execute 'setlocal filetype=' . filetype
  diffthis
  exe "normal! " . diffline . "G"
endfunction

command DiffOrig call s:DiffWithSaved()

nnoremap <leader>fd :DiffOrig<CR>
