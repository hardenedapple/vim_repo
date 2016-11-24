if index(g:pathogen_disabled, 'fugitive') != -1
  finish
endif

" Fugitive Plugin
autocmd BufReadPost fugitive://* set bufhidden=delete

" Commands taken from
" https://github.com/dhruvasagar/dotfiles/blob/master/vim/commands.vim
command! -bar -nargs=* Gpurr execute 'Git pull --rebase' <q-args> 'origin' fugitive#head()
command! -bar -nargs=0 Gpnp silent Gpull | Gpush
command! -bar -nargs=0 Gprp silent Gpurr | Gpush
command! -bar Gstaged  Git! diff --cached


" Bunch of leader mappings for ease of use
nnoremap <silent> <leader>gw :<C-U>Gwrite<CR>
nnoremap <silent> <leader>gd :<C-U>Gdiff<CR>
nnoremap <silent> <leader>gp :<C-U>Gpush<CR>
nnoremap <silent> <leader>gf :<C-U>Gpurr<CR>
nnoremap <silent> <leader>gc :<C-U>Gcommit<CR>
nnoremap <silent> <leader>gs :<C-U>Gstatus<CR>
