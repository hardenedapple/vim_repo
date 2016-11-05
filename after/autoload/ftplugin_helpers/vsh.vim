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
  call ftplugin_helpers#vsh#RunCommand(ftplugin_helpers#vsh#CommandRange(), l:command)
endfunction

if !has('nvim')
  function ftplugin_helpers#vsh#StartSubprocess()
  endfunction

  function ftplugin_helpers#vsh#RunCommand(command_range, command)
    if a:command_range
      exe a:command_range . '! ' . a:command
    else
      exe 'r! ' .  a:command
    endif
  endfunction
else
  " TODO
  "   Definite things to fix
  "     - Kill shell process when buffer is unloaded
  "       . Run on the BufUnload event
  "       . jobstop(b:vsh_job)
  "       . Don't know how to get that particular buffer.
  "         BufUnload knows what the buffer being closed is from '<afile>', but
  "         the current buffer may be different to that.
  "         I need to fetch a buffer-local variable from a different buffer,
  "         but switching to that buffer would cause problems.
  "     - Fix where the data is put into the buffer
  "       . Don't use a mark that the user can modify
  "       . Ensure you go into the correct buffer.
  "     - Make text object for a command and inner command ('ac', 'ic').
  "       Inner command is just the output of the command, a command includes
  "       the prompt.

  " XXX Inherent problems in the idea
  "     What happens when the user removes the prompt that caused the latest
  "     output?
  "     How should the user use interactive programs?

  " NOTE
  "   Differences if I use a pseudo terminal.
  "      - Can send ^D ^C ^Z ^/ etc to the process, and the pty will figure out
  "        what I want to do.
  "      - ? Is stdout going to be buffered differently (line-wise instead of
  "        entire chunk) ?
  "      - Will have to set terminal settings like no special characters.
  "      - 

  " XXX In the future there may be an option to just echo the data, but this
  " shouldn't be difficult to add given the structure I'm thinking of.
  "
  " TODO
  "   Remember where the current position is

  " TODO Things to check:
  "   What happens if my callback is called from the job when I'm in a different
  "   buffer?
  "     What buffer does this callback execute in?
  "     Would switching buffer switch what buffer the user is in?
  "
  let s:callbacks = {
        \ 'on_stdout': function('ftplugin_helpers#vsh#InsertText'),
        \ 'on_stderr': function('ftplugin_helpers#vsh#InsertText'),
        \ 'on_exit': function('ftplugin_helpers#vsh#SubprocessClosed')
        \ }

  " TODO
  "   If I run the bash process on a new pseudo terminal slave
  "     Make the $TERM variable dumb so I don't have any strange things.
  "     Run a script that changes the tty settings to better suit my use
  "     before execl()'ing bash.
  "     Set PAGER='' and MANPAGER='col -b'
  "     Put jobresize() on an autocmd for a window resize (or if that gets
  "     confusing because you have to find the largest window viewing this
  "     buffer, on the autocmd of resizing Vim).

  function ftplugin_helpers#vsh#StartSubprocess()
    " TODO Take shell from env and allow choosing shell
    "      Store the insert position in some way other than a mark (don't want
    "      to have problems from a user modifying it).
    if get(b:, 'vsh_job', 0)
      echoerr 'Already a subprocess running for this buffer'
      return
    endif
    0 mark d

    let job_id = jobstart(['bash'], extend({'buffer': bufnr('%')}, s:callbacks))
    if job_id == 0
      echoerr "Too many jobs started, can't start another."
    elseif job_id == -1
      echoerr 'Failed to find bash executable.'
    else
      let b:vsh_job = job_id
    endif
  endfunction

  function ftplugin_helpers#vsh#RunCommand(command_range, command)
    if a:command_range
      exe a:command_range . 'd'
      normal k
    endif
    mark d
    let retval = jobsend(b:vsh_job, a:command . "\n")
    if retval == 0
      echoerr 'Failed to send command "' . a:command . '" to subprocess'
    endif
  endfunction

  function ftplugin_helpers#vsh#SubprocessClosed(job_id, data, event)
    " Callback is run in the users current buffer, not the buffer that
    " the job is started in
    " TODO
    "   Remove variable from buffer self.buffer.
    "     Don't know how to check whether self.buffer exists before j
    let curbuffer = bufnr('%')
    if bufexists(self.buffer)
      exe 'keepjumps keepalt buffer ' . self.buffer
      let b:vsh_job = 0
      exe 'keepjumps keepalt buffer ' . curbuffer
    else
      echoerr 'No valid buffer to close with'
    endif
  endfunction

  function ftplugin_helpers#vsh#InsertText(job_id, data, event)
    " TODO Distinguish between stdout and stderr data?
    "     Would I get stderr data from subprocesses of the bash shell as stderr
    "     from the bash shell?
    "       Yes, if the bash process is just a subprocess and not in a new
    "       pseudo terminal.

    " TODO Save user state -- jumps, buffer, position, marks
    let curbuffer = bufnr('%')
    if bufexists(self.buffer)
      exe 'keepjumps keepalt buffer ' . self.buffer
      " TODO  Can't keep using a mark that the user can modify
      'd
      normal $
      call ftplugin_helpers#vsh#MoveToNextPrompt('n')
      put! =a:data
      exe 'keepjumps keepalt buffer ' . curbuffer
    else
      echoerr 'Vsh output coming while no valid buffer remaining'
    endif
  endfunction
    
endif


function ftplugin_helpers#vsh#NewPrompt()
  put = b:prompt . ' '
  startinsert!
endfunction

