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

function NextArg()
  if w:track_this
    let w:track_this = 0
    if bufname('%') == argv()[-1]
      argument 1
    else
      next
    endif
    let w:track_this = 1
  else
    buffer #
  endif
endfunction

function PrevArg()
  if w:track_this
    let w:track_this = 0
    if bufname('%') == argv()[0]
      last
    else
      prev
    endif
    let w:track_this = 1
  else
    buffer #
  endif
endfunction

augroup arglocal_test
  autocmd BufEnter * call s:new_window_setup()
augroup END

nmap <leader>xn :call NextArg()<CR>
nmap <leader>xh :call PrevArg()<CR>
