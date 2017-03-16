let s:project = helpers#working_environment(1)
if s:project == 'vim'
  setlocal shiftwidth=2
  setlocal tabstop=8
  setlocal softtabstop=2
endif

