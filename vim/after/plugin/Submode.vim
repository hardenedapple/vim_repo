" This plugin is in 'after', which means it will be loaded after the submode
" autoload functions. Hence a better check for the plugin that if it's in
" pathogen_disabled is whether it's functions exist.
if !exists('*submode#map')
  finish
endif

let g:submode_keep_leaving_key=1
let g:submode_timeout=0
let g:submode_keyseqs_to_leave=['<Esc>', '<Enter>', 'q']


" Undo submode {{{
call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
call submode#map('undo/redo', 'n', '', '-', 'g-')
call submode#map('undo/redo', 'n', '', '+', 'g+')
" }}}

" {{{ Window submode
call submode#enter_with('windows', 'n', '', 'g<C-w>', 'jk')
" Motion
call submode#map('windows', 'n', '', 'h', '<C-w>h')
call submode#map('windows', 'n', '', 'j', '<C-w>j')
call submode#map('windows', 'n', '', 'k', '<C-w>k')
call submode#map('windows', 'n', '', 'l', '<C-w>l')

call submode#map('windows', 'n', '', 't', '<C-w>t')
call submode#map('windows', 'n', '', 'b', '<C-w>b')
call submode#map('windows', 'n', '', 'p', '<C-w>p')

call submode#map('windows', 'n', '', '1', '1<C-w>w')
call submode#map('windows', 'n', '', '2', '2<C-w>w')
call submode#map('windows', 'n', '', '3', '3<C-w>w')
call submode#map('windows', 'n', '', '4', '4<C-w>w')
call submode#map('windows', 'n', '', '5', '5<C-w>w')
call submode#map('windows', 'n', '', '6', '6<C-w>w')

" Splitting
call submode#map('windows', 'n', '', 'v', '<C-w>v')
call submode#map('windows', 'n', '', 's', '<C-w>s')

" Resizing
call submode#map('windows', 'n', '', '.', '<C-w>>')
call submode#map('windows', 'n', '', ',', '<C-w><')
call submode#map('windows', 'n', '', '>', '10<C-w>>')
call submode#map('windows', 'n', '', '<', '10<C-w><')
call submode#map('windows', 'n', '', ']', '<C-w>+')
call submode#map('windows', 'n', '', '[', '<C-w>-')
call submode#map('windows', 'n', '', '+', '10<C-w>+')
call submode#map('windows', 'n', '', '_', '10<C-w>-')
call submode#map('windows', 'n', '', '=', '<C-w>=')

" Closing
call submode#map('windows', 'n', '', 'c', '<C-w>c')
call submode#map('windows', 'n', '', 'o', '<C-w>o')

" Reorganising
call submode#map('windows', 'n', '', 'r', '<C-w>r')
call submode#map('windows', 'n', '', 'R', '<C-w>R')
call submode#map('windows', 'n', '', 'x', '<C-w>x')
call submode#map('windows', 'n', '', 'H', '<C-w>H')
call submode#map('windows', 'n', '', 'J', '<C-w>J')
call submode#map('windows', 'n', '', 'K', '<C-w>K')
call submode#map('windows', 'n', '', 'L', '<C-w>L')
call submode#map('windows', 'n', '', 'T', '<C-w>T')
" }}}

" {{{ Fold submode
call submode#enter_with('folds', 'n', '', 'zf', 'jk')

" Motion
call submode#map('folds', 'n', '', 'j', 'zj')
call submode#map('folds', 'n', '', 'k', 'zk')
call submode#map('folds', 'n', '', '[', '[z')
call submode#map('folds', 'n', '', ']', ']z')

" windows (I use this submode for motion, so window motion is useful)
call submode#map('folds', 'n', '', '1', '1<C-w>w')
call submode#map('folds', 'n', '', '2', '2<C-w>w')
call submode#map('folds', 'n', '', '3', '3<C-w>w')
call submode#map('folds', 'n', '', '4', '4<C-w>w')
call submode#map('folds', 'n', '', '5', '5<C-w>w')
call submode#map('folds', 'n', '', '6', '6<C-w>w')

" Overall open/close
call submode#map('folds', 'n', '', 'm', 'zm')
call submode#map('folds', 'n', '', 'M', 'zM')
call submode#map('folds', 'n', '', 'r', 'zr')
call submode#map('folds', 'n', '', 'R', 'zR')

" Partial open/close
call submode#map('folds', 'n', '', 'x', 'zx')
call submode#map('folds', 'n', '', 'v', 'zv')
call submode#map('folds', 'n', '', 'o', 'zo')
call submode#map('folds', 'n', '', 'O', 'zO')
call submode#map('folds', 'n', '', 'c', 'zc')
call submode#map('folds', 'n', '', 'C', 'zC')

" Scrolling
call submode#map('folds', 'n', '', 't', 'zt')
call submode#map('folds', 'n', '', 'b', 'zb')
call submode#map('folds', 'n', '', 'z', 'zz')
" }}}

" {{{ Scrolling submode
call submode#enter_with('scrolling', 'n', '', 'gs', 'jk')

" Motion
call submode#map('scrolling', 'n', '', 'e', '<C-e>')
call submode#map('scrolling', 'n', '', 'y', '<C-y>')
call submode#map('scrolling', 'n', '', 'j', '10<C-e>')
call submode#map('scrolling', 'n', '', 'k', '10<C-y>')
call submode#map('scrolling', 'n', '', 'd', '<C-d>')
call submode#map('scrolling', 'n', '', 'u', '<C-u>')
call submode#map('scrolling', 'n', '', 'f', '<C-f>')
call submode#map('scrolling', 'n', '', 'b', '<C-b>')
" }}}


" vim: foldmethod=marker
