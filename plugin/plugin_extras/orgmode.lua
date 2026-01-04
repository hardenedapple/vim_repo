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
-- is.  Have adjusted a function directly in orgmode and that seems to have at
-- least helped.
--
-- Also having a trouble with flickering syntax highlighting unless I set the
-- following.  Not 100% sure it's a good idea, but at least seems to be
-- improving things.
-- lua vim.g._ts_force_sync_parsing = 1

-- Doing some memory profiling in order to find the memory leak that is bugging
-- me so much.
-- require('jit.v').start()
-- misc.memprof.start('/home/mmalcomson/mem-output.bin')
