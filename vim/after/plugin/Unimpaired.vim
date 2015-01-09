if index(g:pathogen_disabled, 'unimpaired') != -1
  finish
endif
" Remove the deprecated mappings, I never use them on purpose, and quite often
" by accident.
nunmap [o
nunmap ]o
