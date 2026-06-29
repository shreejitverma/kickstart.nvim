-- snacks.nvim — a collection of small, high-quality QoL modules.
-- https://github.com/folke/snacks.nvim
--
-- We intentionally leave snacks' `picker` OFF (telescope is the finder) and
-- `notifier` OFF (noice owns messages/notifications) to avoid duplication.

vim.pack.add { 'https://github.com/folke/snacks.nvim' }

-- The default snacks dashboard "startup" section calls `require('lazy.stats')`
-- to print "Neovim loaded X plugins". This config uses vim.pack (not lazy.nvim),
-- so that module doesn't exist and the dashboard throws on UIEnter/resize.
-- Replace it with a footer sourced from vim.pack instead.
local function pack_footer()
  local ok, plugins = pcall(vim.pack.get)
  local total, active = 0, 0
  if ok then
    total = #plugins
    for _, p in ipairs(plugins) do
      if p.active then
        active = active + 1
      end
    end
  end
  return {
    align = 'center',
    padding = 1,
    text = {
      { '⚡ Neovim loaded ', hl = 'footer' },
      { active .. '/' .. total .. ' plugins', hl = 'special' },
    },
  }
end

require('snacks').setup {
  bigfile = { enabled = true }, -- disable heavy features in huge files
  dashboard = {
    enabled = true, -- startup screen
    -- snacks' default dashboard keys hardcode Nerd Font icons and ignore
    -- vim.g.have_nerd_font, so override them with plain-text entries to avoid
    -- tofu on terminals without a Nerd Font.
    preset = {
      keys = {
        { icon = '', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
        { icon = '', key = 'n', desc = 'New File', action = ':ene | startinsert' },
        { icon = '', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = '', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = '', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })" },
        { icon = '', key = 's', desc = 'Restore Session', section = 'session' },
        { icon = '', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
      pack_footer,
    },
  },
  indent = { enabled = true }, -- indent guides + scope
  input = { enabled = true }, -- better vim.ui.input
  quickfile = { enabled = true }, -- render files before plugins load
  scope = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true }, -- LSP reference highlight navigation
  notifier = { enabled = false },
  picker = { enabled = false },
}

local Snacks = require 'snacks'

-- stylua: ignore start
vim.keymap.set('n', '<leader>gl', function() Snacks.lazygit() end, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>go', function() Snacks.gitbrowse() end, { desc = 'Git [O]pen in browser' })
vim.keymap.set({ 'n', 't' }, '<leader>tt', function() Snacks.terminal() end, { desc = '[T]oggle [T]erminal' })
vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = '[Z]en mode' })
vim.keymap.set('n', '<leader>.', function() Snacks.scratch() end, { desc = 'Toggle scratch buffer' })
vim.keymap.set('n', ']]', function() Snacks.words.jump(1) end, { desc = 'Next reference' })
vim.keymap.set('n', '[[', function() Snacks.words.jump(-1) end, { desc = 'Prev reference' })
-- stylua: ignore end

-- A few quality-of-life toggles under the existing <leader>t group.
Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
Snacks.toggle.diagnostics():map '<leader>td'
Snacks.toggle.line_number():map '<leader>tl'
