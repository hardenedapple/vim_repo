#!/bin/bash

# Copy/pasted from some output and search-replaced into a valid set of actions,
# so this is not pretty, but it at least gets the job done.
cd ~/.vim

do_update () {
    branch=${2:-master}
    if pushd $1 >/dev/null; then
        echo $1
        git checkout -q $2
        git pull --ff-only | grep -v 'Already up to date.'
        popd > /dev/null
    else
        echo "XXX -- $1 missing!! XXX"
    fi
}

for i in abolish arduinosyntax commentary ctrlp dentures dispatch easygrep eunuch exchange fugitive grepper gv lawrencium linediff neomake nvim-lspconfig nvim-treesitter nvim-treesitter-context nvim-treesitter-textobjects obsession orgmode pathogen plenary repeat sideways sneak snippets submode surround tabular telescope telescope-project telescope-ui-select undotree unimpaired vimfindsme vimple visualstar vsh
do
    do_update bundle/$i
done

for i in ctrlp-funky friendly-snippets gnupg nvim-snippets telescope-arglist
do
    do_update bundle/$i main
done

# Possibly something to do with orgmode -- depends on what changes I make and
# what is useful.
