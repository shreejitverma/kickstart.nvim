-- CodeCompanion — provider-agnostic in-editor AI: chat, inline edits, and an
-- agentic tool loop (@editor, @cmd_runner, @files, ...). Anthropic-first on
-- claude-opus-4-8. Reads ANTHROPIC_API_KEY from the environment.
-- (Other providers — OpenAI, Gemini, Copilot, Ollama — work by setting their
-- adapter + key; see :h codecompanion-adapters.)
-- https://github.com/olimorris/codecompanion.nvim

vim.pack.add {
  'https://github.com/olimorris/codecompanion.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/ravitemer/mcphub.nvim', -- ensure module present for the MCP extension below
}

require('codecompanion').setup {
  adapters = {
    anthropic = function()
      return require('codecompanion.adapters').extend('anthropic', {
        schema = { model = { default = 'claude-opus-4-8' } },
      })
    end,
  },
  strategies = {
    chat = { adapter = 'anthropic' },
    inline = { adapter = 'anthropic' },
    cmd = { adapter = 'anthropic' },
  },
  extensions = {
    mcphub = {
      callback = 'mcphub.extensions.codecompanion',
      opts = {
        make_tools = true,
        show_server_tools_in_chat = true,
        -- make_vars / make_slash_commands eagerly iterate MCP resources, which
        -- crashes when the mcp-hub daemon isn't connected yet. Tools register
        -- lazily and are the main agentic value, so keep only those.
        make_vars = false,
        make_slash_commands = false,
      },
    },
  },
}

-- stylua: ignore start
vim.keymap.set({ 'n', 'v' }, '<leader>aa', '<Cmd>CodeCompanionChat Toggle<CR>', { desc = 'CodeCompanion chat' })
vim.keymap.set({ 'n', 'v' }, '<leader>ap', '<Cmd>CodeCompanionActions<CR>', { desc = 'CodeCompanion actions palette' })
vim.keymap.set({ 'n', 'v' }, '<leader>ai', '<Cmd>CodeCompanion<CR>', { desc = 'CodeCompanion inline' })
vim.keymap.set('v', '<leader>ad', '<Cmd>CodeCompanionChat Add<CR>', { desc = 'CodeCompanion add selection to chat' })
-- stylua: ignore end
