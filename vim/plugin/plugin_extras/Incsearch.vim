let g:incsearch#auto_nohlsearch = 1
let g:incsearch#consistent_n_direction = 1
let g:incsearch#do_not_save_error_message_history = 1

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" As use the automatic unhilight, now unmap the hlsearch mapping
" Leaving the mapping in vimrc so when I copy the vimrc across to other boxes
" without installing all the plugins I still have the mapping without having to
" think about anything else.
nunmap <leader>nh
