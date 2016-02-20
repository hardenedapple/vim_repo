

function ftplugin_helpers#vsh#CurrentPrompt()
  " Handle being at the start of the file
  let l:retval = search(b:prompt, 'bncW', 0)
  return l:retval ? l:retval : 1
endfunction

function ftplugin_helpers#vsh#NextPrompt()
  " Handle being at the end of the file
  let l:eof = line('$')
  let l:retval = search(b:prompt, 'nW', l:eof)
  return l:retval ? l:retval : l:eof + 1
endfunction

function ftplugin_helpers#vsh#MoveToNextPrompt(mode)
  if a:mode == 'v'
    normal! gv
  endif
  call search(b:prompt, 'e')
  if a:mode != 'n'
    normal! k
  endif
endfunction

function ftplugin_helpers#vsh#MoveToPrevPrompt(mode)
  if a:mode == 'v'
    normal! gv
  endif
  call search(b:prompt, 'be')
  if a:mode != 'n'
    normal! j
  endif
endfunction

function ftplugin_helpers#vsh#ParseVSHCommand(line)
  let l:command = a:line[match(a:line, b:prompt) + len(b:prompt):]
  " Allow notes in the file -- make lines beginning with # a comment.
  " Can't just pass the # on to the bash command, as it gets expanded out in
  " the 'exe' command.
  if l:command[0] == '#'
    return ''
  endif
  return l:command
endfunction

function ftplugin_helpers#vsh#CommandRange()
  let l:eof = line('$')
  let l:startline = ftplugin_helpers#vsh#CurrentPrompt()
  let l:nextprompt = ftplugin_helpers#vsh#NextPrompt()
  let l:cur_output_len = l:nextprompt - l:startline
  if l:cur_output_len < 0
    let l:tmp = l:eof - l:startline
    let l:cur_output_len = l:tmp ? l:tmp : 1
  endif
  if l:cur_output_len == 1
    return ''
  else
    return (l:startline + 1) . ',' . (l:nextprompt - 1)
  endif
endfunction

function ftplugin_helpers#vsh#ReplaceInput()
  let l:command = ftplugin_helpers#vsh#ParseVSHCommand(getline(ftplugin_helpers#vsh#CurrentPrompt()))
  let l:command_range = ftplugin_helpers#vsh#CommandRange()
  if l:command_range
    exe l:command_range . '! ' . l:command
  else
    exe 'r! ' .  l:command
  endif
endfunction

function ftplugin_helpers#vsh#NewPrompt()
  put = b:prompt
  startinsert!
endfunction

