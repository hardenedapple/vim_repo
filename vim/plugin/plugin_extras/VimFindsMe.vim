let g:vfm_use_system_find=1

" Change all the mappings, as the current ones clash with my Fugitive mappings.
nmap <silent> <leader>me <Plug>vfm_browse_files
nmap <silent> <leader>ma <Plug>vfm_browse_args
nmap <silent> <leader>md <Plug>vfm_browse_dirs
nmap <silent> <leader>mp <Plug>vfm_browse_paths
nmap <silent> <leader>mm <Plug>vfm_argument

" Here I want to do basically the same as :VFMArglist but with buffers.
" That is, I initialise the VFM list with all existing buffers, and have the
" resultant buffer the new arglist.
function! My_vfm_args_callback()
  let arg = line('.')
  exe ':args ' . join(vfm#select_buffer(), ' ')
  exe 'argument ' . arg
endfunction

function! VFMArgsFromBufferList()
  let auto_act = g:vfm_auto_act_on_single_filter_result
  let g:vfm_auto_act_on_single_filter_result = 0
  let buffer_names = map(vimple#ls#new().to_l('listed'), "v:val.name")
  call vfm#show_list_overlay(buffer_names)
  let g:vfm_auto_act_on_single_filter_result = auto_act
  call vfm#overlay_controller({'<enter>' : ':call My_vfm_args_callback()'})
endfunction

command! -nargs=0 -bar VFMAB call VFMArgsFromBufferList()
nnoremap <silent> <leader>mc :VFMAB<CR>
