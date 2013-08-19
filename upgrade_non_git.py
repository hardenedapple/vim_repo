#!/usr/bin/env python
"""
script that downloads the latest version of bufexplorer from vim.org
and gets the latest version of pathogen.vim from github.

Uses python3 - for python2, use urllib2 for urlopen and urllib for urlretrieve

For bufexplorer:
Assumes the encoding is defined with charset=...'
Assumes the first occurance of download id is the latest and the one I want.
"""

from io import BytesIO
import os.path
import re
import sys
import urllib.request as urlreq
import zipfile


def find_latest_bufexp():
    """returns the url for the latest zipped script of bufexplorer"""
    url = 'http://www.vim.org/scripts/script.php?script_id=42'
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


def get_bufexp():
    """downloads the latest bufexplorer script to file"""
    page = urlreq.urlopen(find_latest_bufexp())
    zpf = zipfile.ZipFile(BytesIO(page.read()))
    zpf.extractall('vim/bundle/bufexplorer')


def get_pathogen():
    """Download the pathogen script"""
    pathurl = \
    'https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
    urlreq.urlretrieve(pathurl, 'vim/autoload/pathogen.vim')


def get_hybrid():
    """Download hybrid colorscheme - not including the Xdefaults recommended"""
    basepath = 'https://raw.github.com/w0ng/vim-hybrid/master/colors/'
    end_paths = ['hybrid.vim', 'hybrid-light.vim']
    for name in end_paths:
        pathurl = basepath + name
        urlreq.urlretrieve(pathurl, 'vim/colors/' + name)

if __name__ == '__main__':
    myfuncs = {'bufexp': get_bufexp, 'path': get_pathogen,
               'hybrid': get_hybrid}
    if len(sys.argv) == 1:
        get_bufexp()
        get_pathogen()
        get_hybrid()
    else:
        for mod in sys.argv[1:]:
            if mod in myfuncs:
                myfuncs[mod]()
