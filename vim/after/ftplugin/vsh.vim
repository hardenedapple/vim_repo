if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let b:prompt = 'vimshell: > '

function s:CurrentPrompt()
  " Handle being at the start of the file
  let l:retval = search(b:prompt, 'bncW', 0)
  return l:retval ? l:retval : 1
endfunction

function s:NextPrompt()
  " Handle being at the end of the file
  let l:eof = line('$')
  let l:retval = search(b:prompt, 'nW', l:eof)
  return l:retval ? l:retval : l:eof + 1
endfunction

function s:MoveToNextPrompt()
  call search(b:prompt, 'e')
endfunction!

function s:MoveToPrevPrompt()
  call search(b:prompt, 'be')
endfunction!

function s:ParseVSHCommand(line)
  return a:line[match(a:line, b:prompt) + len(b:prompt):]
endfunction!

function s:CommandRange()
  let l:eof = line('$')
  let l:startline = s:CurrentPrompt()
  let l:nextprompt = s:NextPrompt()
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
endfunction!

function s:ReplaceInput()
  let l:command = s:ParseVSHCommand(getline(s:CurrentPrompt()))
  let l:command_range = s:CommandRange()
  if l:command_range
    exe l:command_range . '! ' . l:command
  else
    exe 'r! ' .  l:command
  endif
endfunction!

function s:NewPrompt()
  put = b:prompt
  startinsert!
endfunction!

nnoremap <buffer> <silent> <C-n> :call <SID>MoveToNextPrompt()<CR>
nnoremap <buffer> <silent> <C-p> :call <SID>MoveToPrevPrompt()<CR>
nnoremap <buffer> <silent> <CR>  :call <SID>ReplaceInput()<CR>
nnoremap <buffer> <silent> <localleader>n  :call <SID>NewPrompt()<CR>
nnoremap <buffer> <localleader>o  :<C-r>=<SID>CommandRange()<CR>
