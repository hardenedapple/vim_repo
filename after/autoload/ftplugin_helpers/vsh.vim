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

" Skipping whitespace with 'normal w' doesn't do much most of the time, but it
" means that we don't need to include a trailing space in the b:prompt
" variable, the cursor position is a little nicer for changing a previous
" command when using the two move funtions below, and a prompt without a
" command or trailing whitespace isn't overwritten by the output of a command
" above it.
function s:MoveToPromptStart()
  let promptline = line('.')
  normal w
  if line('.') != promptline
    normal k$
  endif
endfunction

" Test cases for moving around:
"
"
" vimcmd: >
" vimcmd: >    	Hello there
" vimcmd: > eieio
" vimcmd: >   
" vimcmd: > 
"
"

function ftplugin_helpers#vsh#MoveToNextPrompt(mode)
  " Description:
  "   Searches forward until the next prompt in the current buffefr.
  "   Moves the cursor to the start of the command in that buffer.
  "   If there are spaces between the prompt and the command line then skip
  "   them until reach the first character in the command.
  "   If there is no command after the prompt, move to the end of the line.
  " TODO
  "   Make sure that don't end up on the next line if there is nothing after
  "   the prompt.
  if a:mode == 'v'
    normal! gv
  endif
  call search(b:prompt, 'eW')
  if a:mode != 'n'
    normal! k
  endif
  call s:MoveToPromptStart()
endfunction

function ftplugin_helpers#vsh#MoveToPrevPrompt(mode)
  " For description see above.
  let origcol = virtcol('.')
  normal 0
  if a:mode == 'v'
    normal! gv
  endif
  if search(b:prompt, 'beW') == 0
    exe 'normal ' . origcol . '|'
    return
  endif
  if a:mode != 'n'
    normal! j
  endif
  call s:MoveToPromptStart()
endfunction

function ftplugin_helpers#vsh#ParseVSHCommand(line)
  " Check we've been given a command line and not some junk
  let promptstart = match(a:line, b:prompt)
  if promptstart == -1
    return ''
  endif

  let l:command = a:line[promptstart + len(b:prompt):]
  " Allow notes in the file -- make lines beginning with # a comment.
  " Can't just pass the # on to the bash command, as it gets expanded out in
  " the 'exe' command.
  if l:command =~ '\s*#'
    return ''
  endif
  return l:command
endfunction

function ftplugin_helpers#vsh#CommandRange()
  let l:eof = line('$')
  let l:startline = ftplugin_helpers#vsh#CurrentPrompt()
  " If no current prompt, no range
  if l:startline == 0
    return ''
  endif

  let l:nextprompt = ftplugin_helpers#vsh#NextPrompt()
  let l:cur_output_len = l:nextprompt - l:startline

  " If we are at the last prompt in the file, range is from here to EOF.
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
  if l:command == ''
    return
  endif
  let l:command_range = ftplugin_helpers#vsh#CommandRange()
  if l:command_range
    exe l:command_range . '! ' . l:command
  else
    exe 'r! ' .  l:command
  endif
endfunction

function ftplugin_helpers#vsh#NewPrompt()
  put = b:prompt . ' '
  startinsert!
endfunction

