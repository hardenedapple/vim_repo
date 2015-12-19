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
setlocal comments=b:vimshell\:\ >
setlocal formatoptions+=r
setlocal formatoptions+=o

nnoremap <buffer> <silent> <C-n> :call ftplugin_helpers#vsh#MoveToNextPrompt()<CR>
nnoremap <buffer> <silent> <C-p> :call ftplugin_helpers#vsh#MoveToPrevPrompt()<CR>
nnoremap <buffer> <silent> <CR>  :call ftplugin_helpers#vsh#ReplaceInput()<CR>
nnoremap <buffer> <silent> <localleader>n  :call ftplugin_helpers#vsh#NewPrompt()<CR>
nnoremap <buffer> <localleader>o  :<C-r>=ftplugin_helpers#vsh#CommandRange()<CR>
