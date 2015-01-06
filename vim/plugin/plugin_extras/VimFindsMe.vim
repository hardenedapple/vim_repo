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

"--------------------------        Callbacks         --------------------------
" Copy of vfm_args_callback -- loads all files in the buffer to arglist
function My_vfm_args_callback()
  let arg = line('.')
  exe ':args ' . join(vfm#select_buffer(), ' ')
  exe 'argument ' . arg
endfunction

" Remove a whole bunch of buffers at the same time
function My_vfm_bufwipe_callback()
  for buffer_name in vfm#select_buffer()
    exe 'bwipe ' . buffer_name
  endfor
endfunction

" Add a whole load of buffers at the same time
function My_vfm_buffer_add_callback()
  let buf_choice = getline('.')
  for buffer_name in vfm#select_buffer()
    exe 'badd ' . buffer_name
  endfor
  exe 'buffer ' . buf_choice
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


" Does the same as VimFindsMeFiles, but the <enter> callback at the end is
" specified with an argument.
function VimFindWithFiles(path, enter_command) "{{{
  let paths = filter(split(a:path, '\\\@<!,'), 'v:val !~ "^\s*;\s*$"')
  let cwd = getcwd()

  if index(paths, '.') != -1
    call add(paths, fnamemodify(expand('%'), ":p:h"))
  endif

  if (index(paths, '') != -1) || (index(paths, '**') != -1)
    call add(paths, cwd)
  endif

  call map(vfm#uniq(sort(filter(paths, 'index(["", ".", "**"], v:val) == -1')))
        \, 'substitute(v:val, "^" . cwd, ".", "")')

  if empty(paths)
    echohl Warning
    echom "VFM has nothing to do: paths empty."
    echohl None
    return
  endif

  if (cwd == fnamemodify($HOME, ':p:h'))
        \ && (g:vfm_skip_home == 1)
        \ || ((index(paths, '.') != -1) && (g:vfm_maxdepth == -1))
    echohl Warning
    echom "VFM skipping $HOME"
    echohl None
    return
  endif

  call map(paths, 'fnameescape(v:val)')

  let find_prune = ' '
        \. join(map(copy(g:vfm_ignore),
        \    ' "-name " . fnameescape(v:val) . " -prune "'), ' -o ')
        \. '-o ' . (g:vfm_hide_dirs ? ' -type f ' : '') . ' -print'

  let find_depth = (g:vfm_maxdepth == -1 ? '' : ' -maxdepth ' . g:vfm_maxdepth)

  let find_cmd = "find -L " . join(paths, " ") . find_depth . find_prune
        \. ' 2>/dev/null'

  if g:vfm_use_system_find
    call vfm#show_list_overlay(vfm#uniq(sort(split(system(find_cmd), "\n"))))
  else
    let dotted = filter(vfm#globpath(join(paths, ','), '**/.*', 0, 1), 'v:val !~ "\\.\\.\\?$"')
    let files  = vfm#uniq(sort(dotted + vfm#globpath(join(paths, ','), '**/*', 0, 1)))
    call vfm#show_list_overlay(files)
  endif
  call vfm#overlay_controller({'<enter>' : a:enter_command})

endfunction "}}}

command -nargs=0 -bar VFMBadd call VimFindWithFiles(&path, ':call My_vfm_buffer_add_callback()')
command -nargs=0 -bar VFMAB call VFMCallMultiple(map(vimple#ls#new().to_l('listed'), 'v:val.name'), ':call My_vfm_args_callback()')
command -nargs=0 -bar VFMBwipe call VFMCallMultiple(map(vimple#ls#new().to_l('listed'), 'v:val.name'), ':call My_vfm_bufwipe_callback()')
nnoremap <silent> <leader>mb :VFMBadd<CR>
nnoremap <silent> <leader>mc :VFMAB<CR>
nnoremap <silent> <leader>mw :VFMBwipe<CR>

