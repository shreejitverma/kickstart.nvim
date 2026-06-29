-- harpoon (v2) — pin a handful of files and teleport between them instantly.
-- https://github.com/ThePrimeagen/harpoon
-- Moved off <leader>a / <leader>m to free the <leader>a "AI" group:
--   <leader>A add · <leader>H menu · <leader>1..5 jump to slot.

vim.pack.add {
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
  'https://github.com/nvim-lua/plenary.nvim',
}

local harpoon = require 'harpoon'
harpoon:setup {}

-- stylua: ignore start
vim.keymap.set('n', '<leader>A', function() harpoon:list():add() end, { desc = 'Harpoon [A]dd file' })
vim.keymap.set('n', '<leader>H', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon menu' })
for i = 1, 5 do
  vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon to file ' .. i })
end
-- stylua: ignore end
