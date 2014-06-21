" Fugitive Plugin
autocmd BufReadPost fugitive://* set bufhidden=delete

" Commands from taken from
" https://github.com/dhruvasagar/dotfiles/blob/master/vim/commands.vim
command! -bar -nargs=* Gpull execute 'Git pull' <q-args> 'origin' fugitive#head()
command! -bar -nargs=* Gpush execute 'Git push' <q-args> 'origin' fugitive#head()
command! -bar -nargs=* Gpurr execute 'Git pull --rebase' <q-args> 'origin' fugitive#head()
command! Gpnp silent Gpull | Gpush
command! Gprp silent Gpurr | Gpush


" Bunch of leader mappings for ease of use
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gp :Gpush<CR>
nnoremap <silent> <leader>gf :Gpurr<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gs :Gstatus<CR>

