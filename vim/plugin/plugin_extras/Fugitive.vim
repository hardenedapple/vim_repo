" Fugitive Plugin
autocmd BufReadPost fugitive://* set bufhidden=delete

" Commands from taken from
" https://github.com/dhruvasagar/dotfiles/blob/master/vim/commands.vim
command! -bar -nargs=* Gpull execute 'Git pull' <q-args> 'origin' fugitive#head()
command! -bar -nargs=* Gpush execute 'Git push' <q-args> 'origin' fugitive#head()
command! -bar -nargs=* Gpurr execute 'Git pull --rebase' <q-args> 'origin' fugitive#head()
command! Gpnp silent Gpull | Gpush
command! Gprp silent Gpurr | Gpush
