-- Git power tools: Neogit (magit-style UI) + Diffview (side-by-side diffs &
-- file history), layered on kickstart's already-active gitsigns.
-- https://github.com/NeogitOrg/neogit · https://github.com/sindrets/diffview.nvim

vim.pack.add {
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
}

require('diffview').setup {}
require('neogit').setup { integrations = { diffview = true } }

require('which-key').add { { '<leader>g', group = 'Git' } }

-- stylua: ignore start
vim.keymap.set('n', '<leader>gg', '<Cmd>Neogit<CR>', { desc = 'Neogit (status)' })
vim.keymap.set('n', '<leader>gc', '<Cmd>Neogit commit<CR>', { desc = 'Git [C]ommit' })
vim.keymap.set('n', '<leader>gp', '<Cmd>Neogit pull<CR>', { desc = 'Git [P]ull' })
vim.keymap.set('n', '<leader>gP', '<Cmd>Neogit push<CR>', { desc = 'Git [P]ush' })
vim.keymap.set('n', '<leader>gd', '<Cmd>DiffviewOpen<CR>', { desc = 'Diffview open' })
vim.keymap.set('n', '<leader>gD', '<Cmd>DiffviewClose<CR>', { desc = 'Diffview close' })
vim.keymap.set('n', '<leader>gh', '<Cmd>DiffviewFileHistory %<CR>', { desc = 'File [H]istory (current file)' })
vim.keymap.set('n', '<leader>gH', '<Cmd>DiffviewFileHistory<CR>', { desc = 'File [H]istory (repo)' })

-- Fill in kickstart's reserved "Git [H]unk" group using the already-loaded gitsigns.
local gs = require 'gitsigns'
vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { desc = 'git [S]tage hunk' })
vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = 'git [R]eset hunk' })
vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { desc = 'git [S]tage buffer' })
vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { desc = 'git [R]eset buffer' })
vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = 'git [P]review hunk' })
vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = 'git [B]lame line' })
vim.keymap.set('n', '<leader>hd', gs.diffthis, { desc = 'git [D]iff against index' })
vim.keymap.set('n', ']c', function() gs.nav_hunk 'next' end, { desc = 'Next git change' })
vim.keymap.set('n', '[c', function() gs.nav_hunk 'prev' end, { desc = 'Prev git change' })
-- stylua: ignore end
