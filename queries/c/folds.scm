;; Copy-paste of the folds.scm file from treesitter standard.
;; *Except* that I removed the comment folding and fold the function *body*
;; rather than the entire function.

[
  (for_statement)
  (if_statement)
  (while_statement)
  (do_statement)
  (switch_statement)
  (case_statement)
  (struct_specifier)
  (enum_specifier)
  (preproc_if)
  (preproc_elif)
  (preproc_else)
  (preproc_ifdef)
  (preproc_function_def)
  (initializer_list)
  (gnu_asm_expression)
] @fold

(compound_statement
  (compound_statement) @fold)
(function_definition
  body: (_) @fold)


