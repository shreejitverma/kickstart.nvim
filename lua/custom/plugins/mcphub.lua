-- mcphub.nvim — manage MCP (Model Context Protocol) servers from Neovim and
-- expose their tools/resources/prompts to CodeCompanion. Requires the `mcp-hub`
-- binary (installed globally via npm) and a servers file at
-- ~/.config/mcphub/servers.json. Add servers there, then use them as @tools in
-- a CodeCompanion chat or via the MCPHub UI.
-- https://github.com/ravitemer/mcphub.nvim

vim.pack.add {
  'https://github.com/ravitemer/mcphub.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
}

require('mcphub').setup {
  config = vim.fn.expand '~/.config/mcphub/servers.json',
}

vim.keymap.set('n', '<leader>au', '<Cmd>MCPHub<CR>', { desc = 'Open MCP Hub' })
