let s:project = helpers#working_environment(1)
if s:project == 'gnu'
  " Coding standards taken from https://gcc.gnu.org/wiki/FormattingCodeForGCC
  setlocal noexpandtab
  setlocal shiftwidth=4
  setlocal tabstop=8
  setlocal softtabstop=4
endif
