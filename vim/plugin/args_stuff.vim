" Add some commands that let me change the argument list with completion for
" buffers instead of files (allows changing the 'working set' more easily).
"
" These commands are much more rarely used once VFM is installed, and I have my
" extra functions defined.
command -nargs=* -complete=buffer Args args <args>
command -nargs=* -complete=buffer Argadd argadd <args>

" This is degenerate (but less featured) with VFMArgument, but kept here for
" machines where I don't have the plugin installed.
function ArglistComplete(ArgLead, CmdLine, CursorPos)
  return filter(map(argv(), 'substitute(v:val, "^\\./", "", "")'), 'v:val =~# "' . a:ArgLead . '"')
endfunction

command -nargs=1 -bar -complete=customlist,ArglistComplete Argument buffer <args>
nnoremap <leader>mm :call feedkeys(":Argument \<c-d>")<cr>

" Add a whole load of buffers at the same time
function MultipleBadd(buffers)
  for buffer_name in split(a:buffers)
    exe 'badd ' . buffer_name
  endfor
endfunction

command -nargs=+ -complete=file Badd call MultipleBadd('<args>')
