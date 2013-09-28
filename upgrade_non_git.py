#!/usr/bin/env python
"""
Script that downloads the latest version of bufexplorer from vim.org
the latest version of c.vim ffrom vim.org, the hybrid colorscheme from
w0ng github and latest version of pathogen.vim from tpop github.

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


def get_bufexp():
    """downloads the latest bufexplorer script to file"""
    bufurl = 'http://www.vim.org/scripts/script.php?script_id=42'
    page = urlreq.urlopen(find_latest_vimscript(bufurl))
    zpf = zipfile.ZipFile(BytesIO(page.read()))
    zpf.extractall('vim/bundle/bufexplorer')
    print('Got bufexplorer')


def get_cvim():
    """downloads the latest cvim script to file"""
    bufurl = 'http://www.vim.org/scripts/script.php?script_id=213'
    page = urlreq.urlopen(find_latest_vimscript(bufurl))
    zpf = zipfile.ZipFile(BytesIO(page.read()))
    zpf.extractall('vim/bundle/cvim')
    print('Downloaded c-vim')


def get_pysyn():
    """Downloads the latest python syntax script to file"""
    bufurl = 'http://www.vim.org/scripts/script.php?script_id=790'
    urlreq.urlretrieve(find_latest_vimscript(bufurl),
                       'vim/bundle/python-extras/syntax/python3.0.vim')
    print('Downloaded python syntax extras')


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


def steal_pymodebits():
    """Copy and modify the bits from pymode for defining motion and indent"""
    # Copy the base parts
    shutil.copy2('vim/bundle/python-mode/autoload/pymode.vim',
                 'vim/bundle/python-extras/autoload')
    call(['patch', 'vim/bundle/python-extras/autoload/pymode.vim',
          'patches/python_stuff/pybase.diff'])
    # Copy autoload/pymode/motion.vim
    shutil.copy2('vim/bundle/python-mode/autoload/pymode/indent.vim',
                 'vim/bundle/python-extras/autoload/pymode')
    shutil.copy2('vim/bundle/python-mode/after/indent/python.vim',
                 'vim/bundle/python-extras/after/indent')
    call(['patch', 'vim/bundle/python-extras/after/indent/python.vim',
          'patches/python_stuff/indentpy.diff'])
    # Copy autoload/pymode/motion.vim
    shutil.copy2('vim/bundle/python-mode/autoload/pymode/motion.vim',
                 'vim/bundle/python-extras/autoload/pymode')
    shutil.copy2('vim/bundle/python-mode/after/ftplugin/python.vim',
                 'vim/bundle/python-extras/after/ftplugin')
    call(['patch', 'vim/bundle/python-extras/after/ftplugin/python.vim',
          'patches/python_stuff/ftplugpy.diff'])

if __name__ == '__main__':
    myfuncs = locals()
    if len(sys.argv) == 1:
        get_bufexp()
        get_pathogen()
        get_hybrid()
        get_cvim()
        get_pysyn()
        steal_pymodebits()
    else:
        for mod in sys.argv[1:]:
            if mod in myfuncs:
                myfuncs[mod]()
