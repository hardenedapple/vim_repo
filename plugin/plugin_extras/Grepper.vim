if index(g:pathogen_disabled, 'grepper') != -1
  finish
endif

" Set global grepper options.
runtime autoload/grepper.vim

" Possibly stop us from being put into the quickfix window.
" let g:grepper.switch = 0

" Possibly change prompt
" let g:grepper.prompt = 0


" Use grep by default
let g:grepper.tools = ['grep', 'git', 'ag', 'ack', 'findstr']

nmap <leader>so <plug>(GrepperOperator)
xmap <leader>so <plug>(GrepperOperator)

command Todo :Grepper
      \ -noprompt
      \ -tool git
      \ -grepprg git grep -nIi '\(TODO\|FIXME\|XXX\)'

function GrepHere()
  let globpattern = expand('%:h') . '/*'
  execute 'Grepper -tool grep -grepprg grep -n $* ' . globpattern
endfunction

command GrepHere call GrepHere()

command GrepBufs :Grepper
      \ -buffers
      \ -query

nnoremap <leader>ss :Grepper -tool grep <CR>
nnoremap <leader>sg :Grepper -tool git <CR>
nnoremap <leader>sd :GrepHere <CR>
nnoremap <leader>sb :GrepBufs <CR>
