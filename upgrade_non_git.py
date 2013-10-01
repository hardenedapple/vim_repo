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


def get_bufexp():
    """downloads the latest bufexplorer script to file"""
    bufurl = 'http://www.vim.org/scripts/script.php?script_id=42'
    page = urlreq.urlopen(find_latest_vimscript(bufurl))
    zpf = zipfile.ZipFile(BytesIO(page.read()))
    zpf.extractall('vim/bundle/bufexplorer')
    print('Downloaded bufexplorer')


def get_cvim():
    """downloads the latest cvim script to file"""
    bufurl = 'http://www.vim.org/scripts/script.php?script_id=213'
    page = urlreq.urlopen(find_latest_vimscript(bufurl))
    zpf = zipfile.ZipFile(BytesIO(page.read()))
    zpf.extractall('vim/bundle/cvim')
    print('Downloaded c-vim')


def get_pysyntax():
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


def steal_pymode():
    """Copy and modify the bits from pymode for defining motion and indent"""
    # Directories I'm working with
    orig = 'vim/bundle/python-mode'
    new = 'vim/bundle/python-extras'
    patch = 'patches/python_stuff'
    # Copy files across from python-mode to python-extras
    for filestr in ['autoload/pymode.vim', 'autoload/pymode/indent.vim',
                    'autoload/pymode/motion.vim', 'after/indent/python.vim',
                    'after/ftplugin/python.vim']:
        shutil.copy2(os.path.join(orig, filestr), os.path.join(new, filestr))
    # Remove the python-mode integration from files
    for filestr in ['autoload/pymode.vim', 'after/indent/python.vim',
                    'after/ftplugin/python.vim']:
        patchfile = os.path.join(patch, filestr.replace('vim', 'diff'))
        call(['patch', os.path.join(new, filestr), patchfile])

    print("Copied pymode's indent and motion scripts to python-extra")

if __name__ == '__main__':
    myfuncs = locals()
    if len(sys.argv) == 1:
        get_bufexp()
        get_pathogen()
        get_hybrid()
        get_pysyntax()
        steal_pymode()
        # cvim is a bit slow - ask for confirmation
        input('Get cvim? ') in ['y', 'Y'] and get_cvim()
    else:
        for mod in sys.argv[1:]:
            if mod in myfuncs and mod != 'find_latest_vimscript':
                myfuncs[mod]()
