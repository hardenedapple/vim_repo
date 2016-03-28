function helpers#external_program_missing(program)
  silent call system('command -v ' . a:program)
  return v:shell_error
endfunction

