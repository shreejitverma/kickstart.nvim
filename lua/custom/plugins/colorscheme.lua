-- Colorscheme — replace kickstart's default Tokyonight with Catppuccin (Mocha).
-- Kanagawa and Rose Pine are installed alongside; switch live with `:colorscheme`.
-- https://github.com/catppuccin/nvim

vim.pack.add {
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
  'https://github.com/rebelot/kanagawa.nvim',
}

require('catppuccin').setup {
  flavour = 'mocha',
  integrations = {
    blink_cmp = true,
    gitsigns = true,
    mini = { enabled = true },
    native_lsp = { enabled = true },
    treesitter = true,
    which_key = true,
    snacks = { enabled = true },
    noice = true,
    mason = true,
    harpoon = true,
    render_markdown = true,
  },
}

vim.cmd.colorscheme 'catppuccin-mocha'
