function! CreateMaskNOpcode(orignum)
  let retval = systemlist('table-to-instruction ' . a:orignum)[0]
  call setline('.', substitute(getline("."), a:orignum, retval, ""))
endfunction

" TODO
"   Generalise this to handle .b .h  --> .h .s
function! ExtendTypes()
  let curline = line('.')
  for i in reverse(['.h', '.s', '.d'])
    execute curline . 't' . curline
    execute 'substitute#\.b#' . i . '#g'
  endfor
endfunction

function! ReplicateTests(orig, newi)
  execute "0/^" . a:orig . "\\>/-1,$?^" . a:orig . "\\>?t$ | '[,']s/" . a:orig . "/" . a:newi
endfunction

command! -bar -range MakeHex <line1>,<line2>substitute/[01]\{32}/\= printf('%08x', str2nr(submatch(0), 2))
command! -bar Hexify <line1>,<line2>substitute/[01]\+/\= printf('%x', str2nr(submatch(0), 2))
command! Binary put =systemlist('table-to-instruction ' . expand('<cword>'))[0]
command! -bar Encodings read! sve-testcase <cword>
command! -bar IVEncodings read! sve-testcase --version=indexed-vector <cword>
command! -bar ThreeEncodings read! sve-testcase --version=three-alts <cword>
command! -bar TriEncodings read! sve-testcase --version=tri-size <cword>
command! -bar TriAltEncodings read! sve-testcase --version=tri-alt <cword>
command! -bar ExtendTypes call ExtendTypes()
command! -bar -nargs=1 Replicate call ReplicateTests(@x, <q-args>)
command! -bar SubMask call CreateMaskNOpcode(expand('<cword>'))
