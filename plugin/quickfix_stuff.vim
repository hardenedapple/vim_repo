" TODO Look into moving all these functions into the autoload directory.
" That way other parts of my config could use this functionality.
" I need this in the FilterQuickfixListByPosition() function, but don't expect
" I'll need it anywhere else.
" On the other hand ... I really don't like the idea of splitting the functions
" based on which I need elsewhere. It seems like they should all be together..
"
" Qargs command from vimcast 45
" Note this function is degenerate with Vimple's QFbufs
" Also, the command Qargs is degenerate with Vimple's QFargs (though QFargs has
" more functionality).
" Despite this, I'm keeping them both, so the "no-plugin" version I get as root
" still has this ability.
function s:QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Filter quicklist from http://dhruvasagar.com/tag/vim
function s:FilterQuickfixListByBuffer(bang, pattern)
  let cmp = a:bang ? '!~#' : '=~#'
  call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) " . cmp . "a:pattern"))
endfunction

function s:FilterQuickfixListBySubject(bang, pattern)
  let cmp = a:bang ? '!~#' : '=~#'
  call setqflist(filter(getqflist(), "v:val['text'] " . cmp . "a:pattern"))
endfunction

" Sort and remove duplicates in qflist
" http://vim.wikia.com/wiki/Automatically_sort_Quickfix_list
function s:CompareQuickfixEntries(i1, i2)
  if bufname(a:i1.bufnr) == bufname(a:i2.bufnr)
    return a:i1.lnum == a:i2.lnum ? 0 : (a:i1.lnum < a:i2.lnum ? -1 : 1)
  else
    return bufname(a:i1.bufnr) < bufname(a:i2.bufnr) ? -1 : 1
  endif
endfunction

function s:SortUniqQFList()
  let sortedList = sort(getqflist(), 's:CompareQuickfixEntries')
  let uniqedList = []
  let last = ''
  for item in sortedList
    let this = bufname(item.bufnr) . "\t" . item.lnum
    if this !=# last
      call add(uniqedList, item)
      let last = this
    endif
  endfor
  call setqflist(uniqedList)
endfunction

" Quickfix saving functions from
" http://vim.1045645.n5.nabble.com/Saving-the-Quickfix-List-td1179523.html
function s:QuickFixSave(fname)
  let list = getqflist()
  for i in range(len(list))
    if has_key(list[i], 'bufnr')
      let list[i].filename = fnamemodify(bufname(list[i].bufnr), ':p')
      unlet list[i].bufnr
    endif
  endfor
  let string = string(list)
  let lines = split(string, "\n")
  call writefile(lines, a:fname)
endfunction

function s:QuickFixRead(fname)
  let lines = readfile(a:fname)
  let string = join(lines, "\n")
  call setqflist(eval(string))
endfunction


" Remove the current quickfix item.
" Useful for marking a quickfix item as 'looked at' when searching for things.

function s:QFitemMatches(qfitem, l, b, c)
  " If the column is 0, then the cursor is left at the start of the text on
  " the relevant line and col('.') can return pretty much anything.
  " I could get the current line, and find the start of text to check that
  " we're pointing at the correct column.
  " I suspect that would have some other problems, as I don't think putting the
  " cursor on the start of the current column is anything stable to be
  " scripting against.
  " Hence we just ignore the column if the quickfix item doesn't specify any
  " particular column.
	" NOTE: With neovim version v0.9 it seems like the cursor is left at the
	" start of the line, and hence col('.') would return 1.  Am not changing on
	" the trust that the above comment holds for some older versions of
	" vim/neovim and it would be nice to still work with those.
  let col_matches = a:qfitem['col'] == a:c || a:qfitem['col'] == 0
	" If the line is 0, then the line to go to is specified by a pattern.
	" Use that pattern to check if we are at the relevant line.
	if a:qfitem['lnum'] != 0
		let chosenline = a:qfitem['lnum']
	else
		let origline = line('.')
		keepjumps 0
		execute 'keepjumps /'.a:qfitem['pattern']
		let chosenline = line('.')
		execute 'keepjumps '.l:origline
	endif
	let line_buf_matches = (l:chosenline == a:l && a:qfitem['bufnr'] == a:b)
  if line_buf_matches && col_matches
    return 1
  endif
  return 0
endfunction

function s:RemoveCurrentQuickfixItem(jump)
  " NOTE:
  "  This function exhibits some known problematic behaviour that I don't know
  "  how to avoid.
  "  If the "current" item in the quickfix list is an invalid entry (e.g. extra
  "  diagnostic from a C compiler), yet the cursor happens to be in the place
  "  that it would be when jumping to a different error in the list, then that
  "  other error is deleted.
  "
  "  This comes from the basic problem that the only way I know of to find the
  "  "current" error is to jump there and see what position I end up in, then
  "  search the quickfix list for an error matching that position.
  "
  "  We could avoid this by jumping to the current error, recording where we
  "  ended up, moving somewhere else and jumping to the current error again.
  "  If we ended up in te same place after the first and second time, then we
  "  must have been moved by the `:cc` command, otherwise we must be on an
  "  invalid line in the quickfix list.
  "
  "  If we were on an invalid line then there would be nothing we could do, and
  "  we would simply have to exit without having done anything.
  "
  "  I'm not doing this because it's ugly ... though having a known problem in
  "  the code is also ugly, so maybe I'm being silly.

  let startbufnr = bufnr('%')
  let startcolumn = virtcol('.')
  let startline = line('.')
  let topline = line('w0') + &scrolloff
  let current_quickfix = getqflist()

  " Get the position of the current quickfix item
  " This is ugly by neccessity: As far as I know, there's no way to find the
  " quickfix item that is "current" without jumping there (with :cc).
  "
  " NOTE:
  "   Even with this I could have simply not moved because the 'current' item
  "   is invalid (e.g. some extra information after a clang error message).
  keepalt keepjumps cc
  let current_line = line('.')
  let current_bufnr = bufnr('%')
  let current_column = col('.')

  " Remove this item from the quickfix list, and all subsequent items that
  " aren't valid.
  " We are assuming that all invalid items after the current one are
  " lines of information about the given error.
  " This is often the case for clang output as an example.
  let cur_index = 0
  let in_err = v:false
  let err_start = -1
  for item in current_quickfix
    if in_err
      if item['valid']
        break
      endif
    elseif s:QFitemMatches(item, current_line, current_bufnr, current_column)
      let err_start = cur_index
      let in_err = v:true
    endif
    let cur_index +=1
  endfor

  " Catch the case where the "current" error line is an invalid one, and the
  " cursor is not currently on an error occurance.
  " Do nothing ... there's no way to figure out which item in the quickfix list
  " we're currently on unless it's a valid item.
  if err_start == -1
    echomsg "Can't find which item is \"current\": Probably an invalid entry."
    return
  endif

  " cur_index is either the index of the next valid item in the quickfix list,
  " or one past the end of the list
  " Either way we need to remove all items in the range [err_start, cur_index)
  call remove(current_quickfix, err_start, cur_index - 1)
  call setqflist(current_quickfix, 'r')

  " Make the 'current' quickfix item the next one in the list.
  " If this item was the last element in the list, go back to the last.
  if err_start < len(current_quickfix)
    execute 'keepalt keepjumps cc ' . (err_start + 1)
  else
    keepalt keepjumps clast
  endif

  " Either jump back to where we started or leave us at the new place depending
  " on given argument.
  if a:jump
    return
  else
    " Return to current state
    execute 'keepalt keepjumps buffer ' . startbufnr
    execute 'keepjumps normal ' . topline . 'zt'
    execute 'keepjumps normal ' . startline . 'gg'
    execute 'keepjumps normal ' . startcolumn . '|'
  endif
endfunction


" Add commands for the functions above.
command -nargs=0 -bar Qargs execute 'args' s:QuickfixFilenames()
command -bang -nargs=1 QFilterBuf call s:FilterQuickfixListByBuffer(<bang>0, <q-args>)
command -bang -nargs=1 QFilterMatch call s:FilterQuickfixListBySubject(<bang>0, <q-args>)
command -range -bang -bar QFilterRange call helpers#FilterQuickfixListByPosition(<bang>0, <line1>, <line2>, v:true)
command -bar QFSort call s:SortUniqQFList()
" Originally I decided not to have file completion QuickFixSave is usually
" creating a new file, and file completion implies I should be overwriting
" one.
" On the other hand completion for directories is much too useful for this
" command to ignore.
command -bar -nargs=1 -complete=file QFSave call s:QuickFixSave(<q-args>)
command -bar -nargs=1 -complete=file QFRead call s:QuickFixRead(<q-args>)
command -bang -bar -nargs=0 QFRemoveCurrent call s:RemoveCurrentQuickfixItem(<bang>0)

nnoremap <silent> <leader>qr :<C-u>QFRemoveCurrent!<CR>
nnoremap <silent> <leader>qs :<C-u>QuickfixSort<CR>
nnoremap <silent> <leader>qb :<C-U>QFilterBuf <C-r>%<CR>
nnoremap <silent> <leader>qd :<C-U>QFilterBuf! <C-r>%<CR>
