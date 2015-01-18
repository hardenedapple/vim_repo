if index(g:pathogen_disabled, 'vimple') != -1
  finish
endif

nmap <silent> <leader>mu <Plug>VimpleMRU

function s:put_into_buffer(to_put, position) range
  let current_buffer = bufname('%')
  execute 'buffer ' . a:to_put
  normal zn
  execute a:position . 'ReadIntoBuffer ' . current_buffer . ' ' . a:firstline . ' ' . a:lastline
  normal zN
  execute 'buffer ' . current_buffer
endfunction

command -nargs=+ -complete=buffer -range PutIntoBuffer :<line1>,<line2>call s:put_into_buffer(<f-args>)
