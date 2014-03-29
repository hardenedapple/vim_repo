" Tell the GnuPG plugin to armor new files
" let g:GPGPreferArmor=1

" Sign new files with my public key?
let g:GPGPreferSign=0

" Don't use gpg-agent
let g:GPGUseAgent=0


augroup GnuPGExtra
    autocmd User GnuPG call SetGPGOptions()
    " Close unmodified files after inactivity
    autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function SetGPGOptions()
    "Set updatetime to 1 minute
    set updatetime=60000
    set foldmethod=marker
    set foldclose=all
    set foldopen=insert
endfunction
