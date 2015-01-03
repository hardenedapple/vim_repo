" Change all the mappings, as the current ones clash
set path=.,**,/usr/include,,
let g:vfm_use_system_find=1

nmap <silent> <leader>me <Plug>vfm_browse_files
nmap <silent> <leader>ma <Plug>vfm_browse_args
nmap <silent> <leader>md <Plug>vfm_browse_dirs
nmap <silent> <leader>mp <Plug>vfm_browse_paths
nmap <silent> <leader>mm <Plug>vfm_argument

" Here I want to do basically the same as :VFMArglist but with buffers.
" That way I can use :VFMArgs on the end buffer to set a new arglist.
