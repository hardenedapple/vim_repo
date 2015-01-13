function s:new_window_setup()
  if !get(w:, 'track_this', 0)
    return
  endif
  let name = bufname('%')
  if get(w:, 'has_own_arglist', 0)
    call s:unique_argadd(name)
    return
  endif
  let w:has_own_arglist = 1
  execute 'arglocal ' . name
endfunction

function s:unique_argadd(name)
  let position = index(argv(), a:name)
  if position > 0
    execute 'argdelete ' . a:name
  endif
  if position != 0
    execute '0argadd ' . a:name
    argument 1
  endif
endfunction

function TrackThisWindow()
  let w:track_this = 1
  call s:new_window_setup()
endfunction

function StopTrackingWindow()
  let w:track_this = 0
endfunction

augroup arglocal_test
  autocmd BufEnter * call s:new_window_setup()
  " The line below is a workaround for losing syntax highlighting
  " It keeps it at the expense of a further flash, and losing the airline
  " colours.
  " autocmd BufEnter * syntax on
augroup END
