-- trouble.nvim — a pretty, navigable list for diagnostics, refs, symbols, qf.
-- https://github.com/folke/trouble.nvim

vim.pack.add { 'https://github.com/folke/trouble.nvim' }

require('trouble').setup {}

require('which-key').add { { '<leader>x', group = 'Trouble/Diagnostics' } }

-- stylua: ignore start
vim.keymap.set('n', '<leader>xx', '<Cmd>Trouble diagnostics toggle<CR>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', '<Cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xs', '<Cmd>Trouble symbols toggle focus=false<CR>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>xl', '<Cmd>Trouble lsp toggle focus=false win.position=right<CR>', { desc = 'LSP refs/defs (Trouble)' })
vim.keymap.set('n', '<leader>xL', '<Cmd>Trouble loclist toggle<CR>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xQ', '<Cmd>Trouble qflist toggle<CR>', { desc = 'Quickfix List (Trouble)' })
-- stylua: ignore end
