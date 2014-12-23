let g:ipy_perform_mappings = 0
let g:ipy_completefunc = 'global'

command -nargs=0 -range IPySend :<line1>,<line2>python dedent_run_these_lines()
" Can use this with the :g command
" That is   :g/print/IPySendLine   would execute all the print statements
command -nargs=0 IPySendLine :python dedent_run_this_line()
