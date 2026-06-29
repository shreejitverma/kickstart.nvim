-- render-markdown.nvim — in-buffer rendering of markdown (headings, code blocks,
-- tables, callouts). Uses the markdown treesitter parsers kickstart already
-- installs, and mini.icons for icons.
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

require('render-markdown').setup {
  completions = { lsp = { enabled = true } },
}

vim.keymap.set('n', '<leader>tm', '<Cmd>RenderMarkdown toggle<CR>', { desc = '[T]oggle [M]arkdown render' })
