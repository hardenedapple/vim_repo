if index(g:pathogen_disabled, 'vim-ipython') != -1
  finish
endif

let g:ipy_perform_mappings = 0
let g:ipy_completefunc = 'global'

" Can use this with the :g command
" That is   :g/print/Pyrun   would execute all the print statements
command -bar -nargs=0 -range Pyrun :<line1>,<line2>python dedent_run_these_lines()

function PyrunThis(type)
  if a:type != 'line'
    return
  endif
  execute "'[,']Pyrun"
endfunction
