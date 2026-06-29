-- noice.nvim — replaces the cmdline, messages and LSP popups with a clean UI.
-- https://github.com/folke/noice.nvim
--
-- We route messages/notifications through noice's built-in `mini` view, so no
-- external notifier (nvim-notify) is required and there's no clash with snacks.

vim.pack.add {
  'https://github.com/folke/noice.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

require('noice').setup {
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  messages = { view = 'mini', view_error = 'mini', view_warn = 'mini' },
  notify = { view = 'mini' },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = true,
  },
}

require('which-key').add { { '<leader>n', group = 'Noice/Notifications' } }

-- stylua: ignore start
vim.keymap.set('n', '<leader>sN', '<Cmd>Noice telescope<CR>', { desc = '[S]earch [N]oice messages' })
vim.keymap.set('n', '<leader>nl', '<Cmd>Noice last<CR>', { desc = 'Noice last message' })
vim.keymap.set('n', '<leader>nh', '<Cmd>Noice history<CR>', { desc = 'Noice history' })
vim.keymap.set('n', '<leader>nd', '<Cmd>Noice dismiss<CR>', { desc = 'Noice dismiss all' })
-- stylua: ignore end
