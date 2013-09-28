My vim dir so that I can easily get my working environment wherever I roam.

CLASHES:
    vim-lawrencium: <C-S> Hgcommit, terminal overrides with freeze

    NerdCommenter uses '\cc' to comment single line and '\cs' to comment 'sexily'
    Cvim uses '\cc' to 'comment with \\' and '\cs' to set comment start
    
    To use python3 omnicompletion etc, need vim compiled with --enable-python3interp
    this breaks python-mode.
    So copy the pymode motion and indent scripts: 
        both from 'autoload' directory, and 'after' directory
        and apply patches to remove pymode interdependancies

    If compiled with python3, symlink python-extra into .vim/bundle directory
    If compiled with python2, symlink python-mode into .vim/bundle directory


NOTES:
    The python script to get upgrades is written for python3.

    Quite a few things don't work with older versions of vim - see the plugins respective websites


CREDITS:
    Pylight and techras are my modified versions of github and default respectively
    Everything comes from someone else - I've just collected them.
    Things hard to google:
        most colors come from vim-colorsamplerpack arch package.
        (colordiff is difference between vim-colorsamplerpack and directory that
        works with set_colors)
