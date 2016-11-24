if index(g:pathogen_disabled, 'vimfindsme') != -1
  finish
endif

let g:vfm_use_system_find=1

" Change all the mappings, as the current ones clash with my Fugitive mappings.
nmap <silent> <leader>me <Plug>vfm_browse_files
nmap <silent> <leader>ma <Plug>vfm_browse_args
nmap <silent> <leader>md <Plug>vfm_browse_dirs
nmap <silent> <leader>mp <Plug>vfm_browse_paths
nmap <silent> <leader>mm <Plug>vfm_argument
nmap <silent> <leader>mc <Plug>vfm_browse_bufs

nnoremap <silent> <leader>mb :<C-U>VFMBadd<CR>
