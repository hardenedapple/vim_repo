" Qargs command from vimcast 45
" Note this function is degenerate with Vimple's QFbufs
" Also, the command Qargs is degenerate with Vimple's QFargs (though QFargs has
" more functionality).
" Despite this, I'm keeping them both, as the "no-plugin" version that I can
" have by not including the plugin_extras/ and bundle/ directory can use these.
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
function s:SaveQuickFixList(fname)
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

function s:LoadQuickFixList(fname)
 let lines = readfile(a:fname)
 let string = join(lines, "\n")
 call setqflist(eval(string))
endfunction


" Remove the current quickfix item.
" Useful for marking a quickfix item as 'looked at' when searching for things.

function s:QFitemMatches(qfitem, l, c, b)
  if a:qfitem['lnum'] == a:l && a:qfitem['col'] == a:c && a:qfitem['bufnr'] == a:b
    return 1
  else
    return 0
  endif
endfunction

function s:RemoveCurrentQuickfixItem(bang)
  " Get the current state
  let startbuffer = bufnr('%')
  let startcolumn = virtcol('.')
  let startline = line('.')
  let topline = line('w0') + &scrolloff
  let current_quickfix = getqflist()

  " Get the position of the current quickfix item
  execute 'keepalt keepjumps cc'
  let current_col = col('.')
  let current_line = line('.')
  let current_bufnr = bufnr('%')

  " Check for the first item, as the loop below wouldn't work if 'item_number'
  " is 0 on the match
  let first_qfitem = current_quickfix[0]
  let item_number = 1
  if s:QFitemMatches(first_qfitem, current_line, current_col, current_bufnr)
    call setqflist(current_quickfix[1:], 'r')
  else
    for item in current_quickfix
      if s:QFitemMatches(item, current_line, current_col, current_bufnr)
        call setqflist(current_quickfix[:item_number-2] + current_quickfix[item_number :], 'r')
        break
      endif
      let item_number +=1
    endfor
  endif

  " Make the 'current' quickfix item the next one in the list.
  execute 'keepalt keepjumps cc' . item_number

  " If the original position was at the item we removed, leave us at the next
  " position, else move back to where we started
  if startline == current_line && startbuffer == current_bufnr && a:bang
    return
  else
    " Return to current state
    execute 'keepalt keepjumps buffer ' . startbuffer
    execute 'keepjumps normal ' . topline . 'zt'
    execute 'keepjumps normal ' . startline . 'gg'
    execute 'keepjumps normal ' . startcolumn . '|'
  endif
endfunction


" Add commands for the functions above.
command -nargs=0 -bar Qargs execute 'args' s:QuickfixFilenames()
command -bang -nargs=1 -complete=file QFilterBuf call s:FilterQuickfixListByBuffer(<bang>0, <q-args>)
command -bang -nargs=1 QFilterMatch call s:FilterQuickfixListBySubject(<bang>0, <q-args>)
command -bar QuickfixSort call s:SortUniqQFList()
command -bar -nargs=1 SaveQuickFixList call s:SaveQuickFixList(<q-args>)
command -bar -nargs=1 -complete=file LoadQuickFixList call s:LoadQuickFixList(<q-args>)
command -bang -bar -nargs=0 QFRemoveCurrent silent call s:RemoveCurrentQuickfixItem(<bang>0)

nnoremap <silent> <leader>qr :<C-u>QFRemoveCurrent!<CR>
