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

" command! -bar -nargs=1 Ldgrep execute 'Ggrep ' . <q-args> . ' -- ''./*'' '':(exclude)*ChangeLog*'' '':(exclude)*.po'' '':(exclude)*testsuite*'' '':(exclude)*.texi'''
command! LDQFFilterBuf QFilterBuf! \(ChangeLog\|bfd/coff\|bfd/ecoff\|bfd/elf-m10\|bfd/elf32-\|bfd/elf64\|bfd/elfnn-\(aarch64\)\@!\|bfd/elfxx-\(aarch64\|target\)\@!\|bfd/pdp\|bfd/mach\|bfd/vms-alpha\|bfd/ihex\|bfd/mmo\|bfd/pef\|bfd/peicode\|bfd/som\|^gdb\|^binutils\|^gas\|^gold\|^sim\|^libiberty\|armelf.em\|cskyelf.em\|hppaelf.em\|m68hc1xelf.em\|metagelf.em\|mipself.em\|nios2elf.em\|ppc64elf.em\|xtensaelf.em\|aout-target\|aoutx\|hppabsd-core\|hpux-core\|irix-core\|libaout\|osf-core\|sc5-core\|verilog\|arc-got\|cpu-ns32k\|elf-hppa\|elf-nacl\|elf-vxworks\|elfn32-mips\|bfd\/pe-\|emultempl\/aix\.em\|emultempl\/alphaelf\.em\|emultempl\/armcoff\|emultempl\/avrelf\|emultempl\/cr16elf\|emultempl\/crxelf\|emultempl\/mmix-\|emultempl\/mmo\.em\|emultempl\/msp430\.em\|emultempl\/pe.em\|emultempl\/needrelax\.em\|emultempl\/vxworks\.em\|aix386-core\)
