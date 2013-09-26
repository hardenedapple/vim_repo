My vim dir so that I can easily get my working environment wherever I roam.

NOTE-TO-SELF: vim-lawrencium maps <C-S> to Hgcommit when in status window - terminal overrides this with 'freeze'
              not sure how I can simply change it without going into the plugin itself - remember to use the 'lawrenciumdiff'
              patch when using this repo

Most colors come from the arch package vim-colorsamplerpack, pylight and techras are my own (modified from others)
The 'colordiff' file is the difference between the directory downloaded from vim-colorsamplerpack and the colors directory
    it's there to change the 'colors_name' variable to fit to the name of the file, as that makes the set_colors script work

Everything interesting comes from somewhere else - google 'vim <dir>' for any dir in the bundle directory.
Pathogen.vim is indispensible for making sense without a package manager.

As Arch has python3 under python by default (and similar for pylint, pep8 etc), syntastic will check python3 scripts.
As python-mode comes with it's own syntax checker (which is for python2), pymode will check python2 scripts.

Jedi vim uses external 'jedi' library (either in python2 or python3).
Vim seems to have trouble being compiled with both python and python2 
support.
Not sure how jedi-vim uses the vim python support, but I think the easiest way
to get support for both is to have a vim different binary for python3 and
python2.
Then, jedi-vim would use the Jedi library in the corresponding site-packages
directory
