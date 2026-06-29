-- flash.nvim — jump anywhere on screen with a few keystrokes.
-- https://github.com/folke/flash.nvim
--
-- NOTE: flash takes over `s` / `S`. kickstart's mini.surround defaults to the
-- `s` prefix (sa/sd/sr...), so we move surround to the `gs` prefix (the
-- LazyVim convention) to avoid the collision. Surround now lives at:
--   gsa (add) · gsd (delete) · gsr (replace) · gsf/gsF (find) · gsh (highlight)

vim.pack.add { 'https://github.com/folke/flash.nvim' }

require('flash').setup {}

local flash = require 'flash'
-- stylua: ignore start
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() flash.jump() end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() flash.treesitter() end, { desc = 'Flash Treesitter' })
vim.keymap.set('o', 'r', function() flash.remote() end, { desc = 'Remote Flash' })
vim.keymap.set({ 'o', 'x' }, 'R', function() flash.treesitter_search() end, { desc = 'Treesitter Search' })
vim.keymap.set('c', '<C-s>', function() flash.toggle() end, { desc = 'Toggle Flash Search' })
-- stylua: ignore end

-- Relocate mini.surround off the `s` prefix so `s` is free for flash.
pcall(function()
  require('mini.surround').setup {
    n_lines = 500,
    mappings = {
      add = 'gsa',
      delete = 'gsd',
      find = 'gsf',
      find_left = 'gsF',
      highlight = 'gsh',
      replace = 'gsr',
      update_n_lines = 'gsn',
      suffix_last = 'l',
      suffix_next = 'n',
    },
  }
  -- Remove the now-shadowed default `s*` maps left over from the base setup.
  for _, lhs in ipairs { 'sa', 'sd', 'sr', 'sf', 'sF', 'sh', 'sn' } do
    pcall(vim.keymap.del, 'n', lhs)
  end
  pcall(vim.keymap.del, 'x', 'sa')
end)
