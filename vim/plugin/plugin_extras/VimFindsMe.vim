let g:vfm_use_system_find=1

" Change all the mappings, as the current ones clash with my Fugitive mappings.
nmap <silent> <leader>me <Plug>vfm_browse_files
nmap <silent> <leader>ma <Plug>vfm_browse_args
nmap <silent> <leader>md <Plug>vfm_browse_dirs
nmap <silent> <leader>mp <Plug>vfm_browse_paths
nmap <silent> <leader>mm <Plug>vfm_argument

" In the functions below, My_vfm_args_callback() is just s:vfm_args_callback()
" from vimfindsme.vim, and VimAddTheseBuffers(path) is just
" VimFindsMeFiles(path) but with a different callback at the end.

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

" Below does mostly the same as VFMEdit, but it adds all the files from the
" resulting buffer to the buffer list.
function! My_vfm_buffer_add_callback()
  let buf_choice = getline('.')
  for buffer_name in vfm#select_buffer()
    exe 'badd ' . buffer_name
  endfor
  exe 'buffer ' . buf_choice
endfunction

function! VimAddTheseBuffers(path) "{{{
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
  call vfm#overlay_controller({'<enter>' : ':call My_vfm_buffer_add_callback()'})

endfunction "}}}

command! -nargs=0 -bar VFMBadd call VimAddTheseBuffers(&path)
command! -nargs=0 -bar VFMAB call VFMArgsFromBufferList()
nnoremap <silent> <leader>mb :VFMBadd<CR>
nnoremap <silent> <leader>mc :VFMAB<CR>
