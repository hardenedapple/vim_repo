" Filetype plugin for all C - type langagues
" should be imported by others.

" add closing of comments when I type the lead
inoremap <buffer> /*  /*<Space><Space>*/<Left><Left><Left>
if stridx(&formatoptions, 'r') != -1
  inoremap <buffer> /*<CR>  /*<CR><CR>/<Esc>kA 
else
  inoremap <buffer> /*<CR>  /*<CR><C-U> */<Esc>O
endif

" Assuming my default keymap is in place.
inoremap <buffer> /8  /*<Space><Space>*/<Left><Left><Left>
if stridx(&formatoptions, 'r') != -1
  inoremap <buffer> /8<CR>  /*<CR><CR>/<Esc>kA 
else
  inoremap <buffer> /8<CR>  /*<CR><C-U> */<Esc>O
endif

" add opening a block with {<CR>
inoremap <buffer> {<CR>  {<CR>}<Esc>O

" Only used for adding markers for folding, and the vim-commentary plugin.
" I find this value more useful for the plugin.
setlocal commentstring=//\ %s

if has('nvim')
	setlocal foldmethod=expr
	setlocal foldexpr=nvim_treesitter#foldexpr()
else
	" The function I've defined works nicely with pretty much all folding styles
	" but is slow if there are too many folds above where you're writing.
	" Hence, by default have foldmethod as syntax.
	setlocal foldmethod=syntax
	setlocal foldexpr=ftplugin_helpers#c_languages#fold_brace()
endif

nnoremap <buffer> <silent> <LocalLeader>n :<C-U>call ftplugin_helpers#c_languages#Togglenewlineadd()<CR>

set formatoptions+=t
let s:project = helpers#working_environment(1)
if s:project == 'solaris'
  setlocal noexpandtab
  setlocal shiftwidth=8
  setlocal tabstop=8
  setlocal cinoptions=t0,+4,(4,u0,U0,W4
elseif s:project == 'gnu'
  " Coding standards taken from https://gcc.gnu.org/wiki/FormattingCodeForGCC
  setlocal noexpandtab
  setlocal shiftwidth=2
  setlocal tabstop=8
  setlocal softtabstop=2
  " vimcmd: vert help fo-table
  " Seems that `set formatoptions-=roc` only works if the format options are in
  " that order already.  That's not guaranteed, so it's best to remove each
  " option one at a time.  (see `:help remove-option-flags`).
  setlocal formatoptions-=r
  setlocal formatoptions-=o
  setlocal formatoptions-=c
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
elseif s:project == 'vim'
  setlocal shiftwidth=2
  setlocal tabstop=8
  setlocal softtabstop=2
endif

" Disable so can use LSP.  I don't really use the default one and would like
" LSP via clang to set this by default.
set omnifunc=
