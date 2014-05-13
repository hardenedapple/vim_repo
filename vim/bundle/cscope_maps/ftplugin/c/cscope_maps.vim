""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE:
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE:
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search through all upper levels to find the cscope database (taken from
" vim.wikia.com/wiki/Autoloading_Cscope_Database)
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
" Call the function every time file is sourced (i.e. every time open a .c file)
call LoadCscope()


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " show msg when any other cscope db added
    set cscopeverbose


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-/ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': 'CTRL-_' (which also maps to CTRL-/) by default
    " is used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    "NOTE: For the split window things below I switched vertical
    "      and horizontal commands, but the comments are the the same
    "      way around - couldn't be bothered to make sure the grammar
    "      was correct.

    " Using 'CTRL-/' (intepreted as CTRL-_ by vim) then a search type
    " makes the vim window split vertically with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-_>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    " Hitting CTRL-/ *twice* before the search type does a horizontal
    " split instead of a horizontal one (vim 6 and up only)
    "
    " NOTE:
    "   <C-_> is only equivalent to <C-/>  in the terminal
    "   In gvim <C-/> is unmappable - as far as I can tell

    nmap <C-_>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-_>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-_>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    nmap <C-_><C-_>s scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_><C-_>g scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_><C-_>c scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_><C-_>t scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_><C-_>e scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-_><C-_>f scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-_><C-_>i scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-_><C-_>d scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif


