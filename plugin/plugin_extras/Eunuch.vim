if index(g:pathogen_disabled, 'eunuch') != -1
  finish
endif

" Mappings for Eunuch.vim and a little file handling function
nnoremap <leader>fr :<C-U>Unlink<CR>
nnoremap <leader>fm :<C-U>Rename 
nnoremap <leader>ff :<C-U>Find 

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

nnoremap <leader>fd :<C-U>DiffOrig<CR>

" Really don't like the :W command.
" I often type W when I mean w, and that ends up saving a bunch of temporary
" changes in all my open windows.
command W write
