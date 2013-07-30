#!/usr/bin/env python

"""Script to update pathogen.vim - I don't want README and CONTRIBUTING, and
the directory structure isn't perfect for clone, so don't use git directly

NOTE: This only works for python3, To use python2, uncomment the imports, and
comment importing urllib.request"""


# from __future__ import print_function
import os.path as path
import re
import shutil
import tempfile
import urllib.request as urlreq
# import urllib2 as urlreq
import zipfile


def get_zipfile(tem_dir):
    """Download pathogen.vim as a zipfile"""
    pathurl = 'https://github.com/tpope/vim-pathogen/archive/master.zip'
    req = urlreq.Request(pathurl)
    handler = urlreq.urlopen(req)
    zippedfile = path.join(tem_dir, 'zipathogen')
    with open(zippedfile, 'wb') as mytmp:
        mytmp.write(handler.read())
    return zippedfile


def extract_zipfile(zippedfile, tem_dir):
    """Extract all vim files from a zipfile - return path"""
    zipf = zipfile.ZipFile(zippedfile)
    files = [f for f in zipf.namelist() if re.match(r'.*\.vim', f)]
    for f in files:
        zipf.extract(f, path=tem_dir)
    return [path.join(tem_dir, f) for f in files]


def put_files(temp_files):
    """Given list of files, move into relative directories in vim dir"""
    vimfiles = [path.join('vim', st[st.find('/') + 1:]) for st in temp_files]
    for f, v in zip(temp_files, vimfiles):
        # Print out filename so I know if something's gone wrong
        print(shutil.move(f, v))


if __name__ == '__main__':
    # public repo - don't need a password
    temp_dir = tempfile.mkdtemp()
    try:
        zipp = get_zipfile(temp_dir)
        taken_files = extract_zipfile(zipp, temp_dir)
        put_files(taken_files)
    finally:
        shutil.rmtree(temp_dir)
