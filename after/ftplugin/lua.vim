setlocal include="^.*require('"
setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.lua'
if helpers#working_environment(1) == 'vim'
  setlocal shiftwidth=2
  setlocal tabstop=2
  setlocal softtabstop=2
endif
