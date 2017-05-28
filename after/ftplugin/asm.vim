" This is used for nasm assembler.
set comments+=b:;

" For GNU assembler on x86 this is the most useful commentstring.
" Apparently for GNU assembler on ARM this would be @ instead ...
" I'll cross that bridge when I come to it.
set commentstring=#\ %s
lmap <buffer> ; :
lmap <buffer> : ;

" Usually doesn't provide any benefit due to the amount of literal numbers.
" Will see if things change when the abstraction levels increase.
setlocal iminsert=0

if exists(':NasmSetup') | finish | endif
" Expect to add to these in the future (which is why I'm creating commands in
" the first place).
command -buffer NasmSetup setlocal commentstring=;\ %s
command -buffer GNUasmSetup setlocal commentstring=#\ %s
