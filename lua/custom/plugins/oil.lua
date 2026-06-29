-- oil.nvim — edit your filesystem like a normal Neovim buffer.
-- https://github.com/stevearc/oil.nvim
-- `-` opens the parent directory; edit/save the buffer to create/rename/delete.

vim.pack.add { 'https://github.com/stevearc/oil.nvim' }

require('oil').setup {
  default_file_explorer = true,
  delete_to_trash = true,
  view_options = { show_hidden = true },
  keymaps = {
    ['<C-h>'] = false, -- keep window navigation
    ['<C-l>'] = false,
    ['q'] = 'actions.close',
  },
}

vim.keymap.set('n', '-', '<Cmd>Oil<CR>', { desc = 'Open parent directory (oil)' })
vim.keymap.set('n', '<leader>e', '<Cmd>Oil --float<CR>', { desc = 'File [E]xplorer (oil float)' })
