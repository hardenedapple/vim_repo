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

" Additional settings, using VimFindsMe as the backbone.

"--------------------------        Callbacks         --------------------------

" Remove a whole bunch of buffers at the same time
function My_vfm_bufwipe_callback()
  for buffer_name in vfm#select_buffer()
    exe 'bwipe ' . buffer_name
  endfor
endfunction

"--------------------------      Initialisation      --------------------------
" Given a start list and a callback, make a VFM command initialised with the
" contents of the list, and with the callback mapped to <enter>
function VFMCallMultiple(input_list, enter_command)
  let auto_act = g:vfm_auto_act_on_single_filter_result
  let g:vfm_auto_act_on_single_filter_result = 0
  call vfm#show_list_overlay(a:input_list)
  let g:vfm_auto_act_on_single_filter_result = auto_act
  call vfm#overlay_controller({'<enter>' : a:enter_command})
endfunction


command -nargs=0 -bar VFMBwipe call VFMCallMultiple(map(vimple#ls#new().to_l('listed'), 'v:val.name'), ':call My_vfm_bufwipe_callback()')
nnoremap <silent> <leader>mb :VFMBadd<CR>
nnoremap <silent> <leader>mw :VFMBwipe<CR>
