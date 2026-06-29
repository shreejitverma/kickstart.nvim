-- neotest — discover, run, watch, and debug tests inside Neovim. Adapters for
-- Python, Go, and Rust; test debugging routes through nvim-dap (custom/dap.lua).
-- https://github.com/nvim-neotest/neotest

vim.pack.add {
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/antoinemadec/FixCursorHold.nvim',
  'https://github.com/nvim-neotest/neotest-python',
  'https://github.com/fredrikaverpil/neotest-golang',
  'https://github.com/rouge8/neotest-rust',
}

-- Load adapters defensively so one missing language toolchain can't break the rest.
local adapters = {}
for _, name in ipairs { 'neotest-python', 'neotest-golang', 'neotest-rust' } do
  local ok, adapter = pcall(require, name)
  if ok then table.insert(adapters, adapter) end
end

require('neotest').setup { adapters = adapters }

require('which-key').add { { '<leader>T', group = 'Test' } }

local nt = require 'neotest'
-- stylua: ignore start
vim.keymap.set('n', '<leader>Tt', function() nt.run.run() end, { desc = 'Test nearest' })
vim.keymap.set('n', '<leader>Tf', function() nt.run.run(vim.fn.expand '%') end, { desc = 'Test file' })
vim.keymap.set('n', '<leader>Ta', function() nt.run.run(vim.fn.getcwd()) end, { desc = 'Test all (suite)' })
vim.keymap.set('n', '<leader>Tl', function() nt.run.run_last() end, { desc = 'Test last' })
vim.keymap.set('n', '<leader>Td', function() nt.run.run { strategy = 'dap' } end, { desc = 'Test debug nearest' })
vim.keymap.set('n', '<leader>TS', function() nt.run.stop() end, { desc = 'Test stop' })
vim.keymap.set('n', '<leader>Ts', function() nt.summary.toggle() end, { desc = 'Test summary toggle' })
vim.keymap.set('n', '<leader>To', function() nt.output.open { enter = true } end, { desc = 'Test output (float)' })
vim.keymap.set('n', '<leader>TO', function() nt.output_panel.toggle() end, { desc = 'Test output panel' })
vim.keymap.set('n', '<leader>Tw', function() nt.watch.toggle(vim.fn.expand '%') end, { desc = 'Test watch file' })
-- stylua: ignore end
