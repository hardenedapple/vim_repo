if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let b:prompt = 'vimshell: > '

" Don't insert newlines when writing a long command
setlocal formatoptions-=t
setlocal formatoptions-=c

" Abuse the comment system to give syntax highlighting (TBD in a syntax file)
" and automatic insertion of the prompt when hitting <Enter>
" NOTE -- order of the comment definition is important -- means lines with a
" '#' are recognised as a comment of the first kind rather than the second,
" which means that pressing <CR> in insert mode when on that line inserts the
" '#' on the next line (assuming the correct 'formatoptions' settings)
setlocal comments=b:vimshell\:\ >\ #,b:vimshell\:\ >
setlocal formatoptions+=r
setlocal formatoptions+=o

nnoremap <buffer> <silent> <C-n> :call ftplugin_helpers#vsh#MoveToNextPrompt('n')<CR>
nnoremap <buffer> <silent> <C-p> :call ftplugin_helpers#vsh#MoveToPrevPrompt('n')<CR>
vnoremap <buffer> <silent> <C-n> :call ftplugin_helpers#vsh#MoveToNextPrompt('v')<CR>
vnoremap <buffer> <silent> <C-p> :call ftplugin_helpers#vsh#MoveToPrevPrompt('v')<CR>
onoremap <buffer> <silent> <C-n> :call ftplugin_helpers#vsh#MoveToNextPrompt('o')<CR>
onoremap <buffer> <silent> <C-p> :call ftplugin_helpers#vsh#MoveToPrevPrompt('o')<CR>
nnoremap <buffer> <silent> <CR>  :call ftplugin_helpers#vsh#ReplaceInput()<CR>
nnoremap <buffer> <silent> <localleader>n  :call ftplugin_helpers#vsh#NewPrompt()<CR>
nnoremap <buffer> <localleader>o  :<C-r>=ftplugin_helpers#vsh#CommandRange()<CR>

" Want: this command would be better if it didn't modify the search history,
" however the obvious function to do that may require storing marks to avoid
" problems with the range that come from changing what's in the file.
command -buffer -range Rerun <line1>,<line2>call ftplugin_helpers#vsh#AllCommands()
