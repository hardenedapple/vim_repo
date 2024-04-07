if index(g:pathogen_disabled, 'vsh') != -1
  finish
endif

" N.b. due to a different order between ftplugin and plugin getting loaded
" after a recent neovim change, if we set `mapleader` *after* running
" `syntax on` then since our vsh plugin will be loaded before `mapleader` is
" set it will not have access to the correct key on which to store mappings.
"
" Putting maps on <Leader> uses `\` by default if these variables are not
" defined (which is problematic for `mapleader` for me).
"
" There's not really anything that vsh can do for this.  I want to put mappings
" on <Leader> and <localleader>.  When those are not defined they should go on
" the default as per vim defaults.  There's not really a way to tell from the
" plugin whether `mapleader` was totally going to be defined later on, or
" whether the defaults were what the end-user wanted.
"
" Hence the only thing for it is for an end user (i.e. a users vimrc) to ensure
" that `mapleader` is set before the vsh plugin is loaded (or for that matter
" any other plugins which put mappings on <leader> and <localleader>).  Since
" it's the `syntax on` part of this vimrc which triggers loading the ftplugin
" for the filetype specified on the command line, and it's the ftplugin for vsh
" that ends up defining mappings, we ensure that these lines are before
" `syntax on`.  I handle this in my vim config by ensuring I don't use `syntax
" on` in my vimrc (as recommended for neovim).
"
" (For ordering behaviour see https://github.com/neovim/neovim/issues/19008)

" My preference for the insert-mode completions.
" I like this better since I like to have "<TAB>" available for indentation.
" This would be in a file named plugin/plugin_extras/Vsh.vim but for the same
" issue as above.
let g:vsh_i_completions = '<C-q>'
