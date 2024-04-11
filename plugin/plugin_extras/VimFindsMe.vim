if index(g:pathogen_disabled, 'vimfindsme') != -1
  finish
endif

let g:vfm_use_system_find=1

" Disable these options because I have better choices.
" Fuzzy finding files better done with `telescope` or `ctrlp`.
" `telescope` specifically because that's much faster to get started on very
" large lists of files (probably at least in part because it's clever about
" which files to ignore).
nmap <plug>unmapping_vfm_browse_files <Plug>vfm_browse_files
" Disable vfm_argument because I want to use the wildmenu instead of C-d to
" show me options.
nmap <plug>unmapping_vfm_argument <Plug>vfm_argument
" Not particularly interested in this one -- I don't set my `&path` very often
" and it doesn't get very large.
nmap <plug>unmapping_vfm_browse_paths <Plug>vfm_browse_paths
" Similarly not very interested in this -- but keeping it around just in case I
" find some interest later.
nmap <silent> <leader>md <Plug>vfm_browse_dirs

" Change all the mappings, as the current ones clash with my Fugitive mappings.
nmap <silent> <leader>ma <Plug>vfm_browse_args
nmap <silent> <leader>mc <Plug>vfm_browse_bufs
" I want something slightly different to <plug>vfm_argument.
" Difference being I want to use wildcharm instead of C-d.
nnoremap <silent> <leader>mm :call feedkeys(':VFMArgument '.nr2char(&wildcharm))<cr>

nnoremap <silent> <leader>mb :<C-U>VFMBadd<CR>
