" Add some commands that let me change the argument list with completion for
" buffers instead of files (allows changing the 'working set' more easily).
"
" These commands are much more rarely used once VFM is installed, and I have my
" extra functions defined.
command -nargs=* -complete=buffer Args args <args>
command -nargs=* -complete=buffer Argadd argadd <args>
