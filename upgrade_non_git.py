#!/usr/bin/env python
"""
Script that downloads the latest version of c.vim from vim.org, the hybrid
colorscheme from w0ng github and latest version of pathogen.vim from tpope
github.

It also copies scripts that I can use with python3 enabled from python-mode
into python-extras.

Uses python3 - for python2, use urllib2 for urlopen and urllib for urlretrieve

For scripts on vim.org:
Assumes the encoding is defined with charset=...'
Assumes the first occurance of download id is the latest and the one I want.
"""

from io import BytesIO
from subprocess import call
import os.path
import re
import sys
import urllib.request as urlreq
import zipfile
import shutil
import re


def find_latest_vimscript(url):
    """returns the url for the latest zipped script on a vimscript page"""
    data = urlreq.urlopen(url).read()
    # This is a completely non-general method of getting the charset
    # MIGHT account for the page charset changing in the future
    charsetpos = data.find(b'charset=') + 8
    charsetlen = data[charsetpos:].find(b'"')
    # assume charset can be expressed in acsii
    charset = data[charsetpos:charsetpos + charsetlen].decode('ascii')
    decdata = data.decode(charset)
    dir_page = os.path.dirname(url)
    downre = re.compile(r'download_script\.php\?src_id=\d*')
    # The first script listed is the latest
    match = downre.search(decdata)
    downloadpage = os.path.join(dir_page, match.group(0))
    return downloadpage


def get_pathogen():
    """Download the pathogen script"""
    pathurl = \
    'https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
    urlreq.urlretrieve(pathurl, 'vim/autoload/pathogen.vim')
    print('Downloaded pathogen')


def get_hybrid():
    """Download hybrid colorscheme - not including the Xdefaults recommended"""
    basepath = 'https://raw.github.com/w0ng/vim-hybrid/master/colors/'
    end_paths = ['hybrid.vim', 'hybrid-light.vim']
    for name in end_paths:
        pathurl = basepath + name
        urlreq.urlretrieve(pathurl, 'vim/colors/' + name)
    print('Downloaded the hybrid colorscheme')


if __name__ == '__main__':
    myfuncs = locals()
    if len(sys.argv) == 1:
        get_pathogen()
        get_hybrid()
    else:
        for mod in sys.argv[1:]:
            if mod in myfuncs and mod != 'find_latest_vimscript':
                myfuncs[mod]()
