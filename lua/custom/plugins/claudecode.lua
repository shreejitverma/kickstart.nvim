-- claudecode.nvim — connect the Claude Code CLI to Neovim as an IDE.
-- Implements the same WebSocket protocol as the official VS Code / JetBrains
-- extensions: Claude sees your selection, diagnostics, and open files, and its
-- edits arrive as native diffs you accept/reject. Uses the `claude` CLI's own
-- auth (your Claude subscription) — no ANTHROPIC_API_KEY required.
-- Terminal is provided by snacks.nvim (already installed).
-- https://github.com/coder/claudecode.nvim

vim.pack.add { 'https://github.com/coder/claudecode.nvim' }

require('claudecode').setup {}

require('which-key').add { { '<leader>a', group = 'AI' } }

-- stylua: ignore start
vim.keymap.set('n', '<leader>ac', '<Cmd>ClaudeCode<CR>', { desc = 'Claude Code toggle' })
vim.keymap.set('n', '<leader>af', '<Cmd>ClaudeCodeFocus<CR>', { desc = 'Claude Code focus' })
vim.keymap.set('n', '<leader>ar', '<Cmd>ClaudeCode --resume<CR>', { desc = 'Claude Code resume' })
vim.keymap.set('n', '<leader>aC', '<Cmd>ClaudeCode --continue<CR>', { desc = 'Claude Code continue' })
vim.keymap.set('n', '<leader>am', '<Cmd>ClaudeCodeSelectModel<CR>', { desc = 'Claude Code select model' })
vim.keymap.set('n', '<leader>ab', '<Cmd>ClaudeCodeAdd %<CR>', { desc = 'Claude Code add current buffer' })
vim.keymap.set('v', '<leader>as', '<Cmd>ClaudeCodeSend<CR>', { desc = 'Claude Code send selection' })
vim.keymap.set('n', '<leader>aA', '<Cmd>ClaudeCodeDiffAccept<CR>', { desc = 'Claude Code accept diff' })
vim.keymap.set('n', '<leader>aD', '<Cmd>ClaudeCodeDiffDeny<CR>', { desc = 'Claude Code deny diff' })
-- stylua: ignore end
