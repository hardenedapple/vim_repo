if vim.list_contains(vim.g.pathogen_disabled, 'orgmode') then
  return
end

-- Mostly want to just use the default mappings.
require('orgmode').setup({
  org_adapt_indentation = false,
  org_startup_indented = true,
  org_edit_src_content_indentation = 2,
})

-- Currently have quite a big problem with slowness.  Not sure what the problem
-- is.
