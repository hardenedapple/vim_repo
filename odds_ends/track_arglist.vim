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
augroup END
