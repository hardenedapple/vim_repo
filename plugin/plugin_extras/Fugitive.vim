if index(g:pathogen_disabled, 'fugitive') != -1
  finish
endif

" Fugitive Plugin
autocmd BufReadPost fugitive://* set bufhidden=delete

" Commands taken from
" https://github.com/dhruvasagar/dotfiles/blob/master/vim/commands.vim
command! -bar -nargs=* Gpurr execute 'Git pull --rebase' <q-args> 'origin' fugitive#head()
command! -bar -nargs=0 Gpnp silent Git pull | Git push
command! -bar -nargs=0 Gprp silent Gpurr | Git push
command! -bar Gstaged  Git! diff --cached


" Bunch of leader mappings for ease of use
nnoremap <silent> <leader>gw :<C-U>Gwrite<CR>
nnoremap <silent> <leader>gd :<C-U>Gdiffsplit<CR>
nnoremap <silent> <leader>gp :<C-U>Git push<CR>
nnoremap <silent> <leader>gc :<C-U>Git commit<CR>
nnoremap <silent> <leader>gs :<C-U>Git<CR>

command! -bar -nargs=1 GNUgrep execute 'Ggrep ' . <q-args> . ' -- ''./*'' '':(exclude)*ChangeLog*'' '':(exclude)*.po'' '':(exclude)*testsuite*'' '':(exclude)*.texi'''


" Helper function for dealing with spelling mistakes
function s:StartSpellFix()
  if get(s:, 'original_commit', '') != ''
    echoerr 'SartSpellFix called while a spellfix is already running'
    echoerr 'Exiting without taking action'
    return
  endif

  let s:orig_pos = getcurpos()
  let s:orig_buf = bufnr('%')
  let worked = v:false
  let dir = getcwd()
  let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd' : 'cd'
  " Go to the root of the repository so we can run the commands below without
  " figuring out where it is.
  execute 'G' . cd
  let output = systemlist('git symbolic-ref --short HEAD 2>/dev/null || git rev-parse HEAD')
  if len(output) == 1
    let original_commit = output[0]
    if len(original_commit) > 0
      let s:original_commit = original_commit
      call system('git stash store $(git stash create)')
      call system('git reset HEAD')
      let worked = v:true
    else
      echoerr 'Found invalid commit description: ' . original_commit
    endif
  else
    echoerr 'Could not record current position of HEAD'
  endif
  execute cd . ' ' . dir
  " Don't want to run Gdiffsplit, *then* cd because we'd have to mess around
  " with figuring out which window to leave the user in etc for if we had to do
  " 'lcd'.
  if worked
    Gedit :0
    " Assume that the line number and column number of the spelling mistake in
    " the working directory is near enough those of the spelling mistake in the
    " index.
    " There's not really any better we can do here.
    call setpos('.', s:orig_pos)
  endif
endfunction

function s:RevertSpellFix()
  call systemlist('git checkout --force '. s:original_commit)
  call systemlist('git stash pop --index')
  unlet s:original_commit
  execute 'b ' . s:orig_buf
  unlet s:orig_buf
  call setpos('.', s:orig_pos)
  unlet s:orig_pos
endfunction

function s:QuitSpellFix()
  if get(s:, 'original_commit', '') == ''
    echoerr 'QuitSpellFix must be called after StartSpellFix'
    echoerr 'QuitSpellFix can not find an internal variable that StartSpellFix sets'
    echoerr 'Exiting without taking action'
    return
  endif

  call s:RevertSpellFix()
endfunction

function s:FinishSpellFix()
  if get(s:, 'original_commit', '') == ''
    echoerr 'FinishSpellFix must be called after StartSpellFix'
    echoerr 'FinishSpellFix can not find an internal variable that StartSpellFix sets'
    echoerr 'Exiting without taking action'
    return
  endif

  let dir = getcwd()
  let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd' : 'cd'
  " Move to git root directory so we can run git commands without worrying.
  execute 'G' . cd
  let output = systemlist('git diff --cached | git patch-id | cut -d" " -f1')
  if len(output) == 1
    let unique_id = output[0]
    if len(unique_id) == 40
      call systemlist('git checkout -b spelling-correction'. unique_id)
      let continue = 2
      if v:shell_error
        echoerr 'git checkout -b spelling-correction' . unique_id . ' failed'
        echoerr 'has this spelling correction already been made?'
        let continue = confirm('What do you want to do?',
              \ "&Revert without commiting spellfix\n&Commit on current branch\n&Do nothing",
              \ 3)
      endif
      if continue == 2
        call systemlist('git commit -m "spelling correction '. unique_id . '"')
      endif
      if continue != 3
        call s:RevertSpellFix()
      endif
    else
      echoerr 'Found invalid length patch-id' . unique_id
    endif
  else
    echoerr 'Could not get patch ID for current changes'
  endif

  execute cd . ' ' . dir
endfunction

command -nargs=0 Gspellfixstart call s:StartSpellFix()
command -nargs=0 Gspellfixend call s:FinishSpellFix()
command -nargs=0 Gspellfixquit call s:QuitSpellFix()
nnoremap <silent> <leader>gf :<C-U>Gspellfixstart<CR>
nnoremap <silent> <leader>gx :<C-U>Gspellfixend<CR>
nnoremap <silent> <leader>gq :<C-U>Gspellfixquit<CR>
