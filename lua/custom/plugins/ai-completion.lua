-- AI inline completion (ghost text) via Supermaven. The free tier needs a
-- one-time `:SupermavenUseFree` (or `:SupermavenUsePro` for the paid tier).
-- Accept a suggestion with <C-g> in insert mode; this coexists with blink.cmp,
-- which keeps Tab / <C-y> for the regular completion menu.
-- https://github.com/supermaven-inc/supermaven-nvim

vim.pack.add { 'https://github.com/supermaven-inc/supermaven-nvim' }

require('supermaven-nvim').setup {
  keymaps = {
    accept_suggestion = '<C-g>',
    clear_suggestion = '<C-e>',
    accept_word = '<C-l>',
  },
  ignore_filetypes = { codecompanion = true },
}
