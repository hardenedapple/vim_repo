if index(g:pathogen_disabled, 'neomake') != -1
  finish
endif

" Add mapping for dispatch
nnoremap <F9> :<C-U>Neomake!<CR>
let g:neomake_place_signs = 0
let g:neomake_highlight_columns = 0
let g:neomake_open_list = 2

" Directly taken from autoload/neomake.vim
" This lets us open the quickfix window without moving the cursor and without
" changing the previous window.
let s:prev_windows = []
function s:save_prev_windows() abort
    let aw = winnr('#')
    let pw = winnr()
    if exists('*win_getid')
        let aw_id = win_getid(aw)
        let pw_id = win_getid(pw)
    else
        let aw_id = 0
        let pw_id = 0
    endif
    call add(s:prev_windows, [aw, pw, aw_id, pw_id])
endfunction

function s:restore_prev_windows() abort
    let [aw, pw, aw_id, pw_id] = remove(s:prev_windows, 0)
    if winnr() != pw
        " Go back, maintaining the '#' window (CTRL-W_p).
        if pw_id
            let aw = win_id2win(aw_id)
            let pw = win_id2win(pw_id)
        endif
        if pw
            if aw
                exec aw . 'wincmd w'
            endif
            exec pw . 'wincmd w'
        endif
    endif
endfunction

function s:open_qf_unobtrusively() abort
  let height = get(g:, 'neomake_list_height', 10)
  call s:save_prev_windows()
  exe g:neomake_hook_context.jobinfo.file_mode ? 'lopen' . height : 'copen' . height
  call s:restore_prev_windows()
endfunction

augroup my_neomake_hooks
  autocmd!
  autocmd User NeomakeFinished nested call s:open_qf_unobtrusively()
augroup END
