" Add some commands that let me change the argument list with completion for
" buffers instead of files (allows changing the 'working set' more easy).
command -nargs=* -complete=buffer Args args <args>
command -nargs=* -complete=buffer Argadd argadd <args>
