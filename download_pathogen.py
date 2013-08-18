#!/usr/bin/env python

"""Script to update pathogen.vim - I don't want README and CONTRIBUTING, and
the directory structure isn't perfect for clone, so don't use git directly

NOTE: This only works for python3, To use python2, change the import of
urllib.request to urllib2"""


import urllib.request as urlreq


if __name__ == '__main__':
    pathurl = \
    'https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
    urlreq.urlretrieve(pathurl, 'vim/autoload/pathogen.vim')
