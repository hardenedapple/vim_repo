if helpers#external_program_missing('cstyle')
  finish
endif

function s:GetCstyle()
  let l:current_compiler=&makeprg
  let l:current_errformat=&errorformat
  compiler cstyle
  make
  let &makeprg=l:current_compiler
  let &errorformat=l:current_errformat
endfunction

command -bar Cstyle call s:GetCstyle()
