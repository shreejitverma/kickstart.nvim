-- cmake-tools.nvim — build/run/debug CMake projects with target discovery,
-- so you pick a target instead of typing an executable path. `:CMakeDebug`
-- builds the selected target and launches it via the codelldb adapter
-- defined in dap.lua.
-- https://github.com/Civitasv/cmake-tools.nvim

vim.pack.add {
  'https://github.com/Civitasv/cmake-tools.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
}

require('cmake-tools').setup {
  cmake_command = 'cmake',
  cmake_build_directory = 'build',
  cmake_dap_configuration = {
    name = 'cmake (codelldb)',
    type = 'codelldb',
    request = 'launch',
    stopOnEntry = false,
  },
}

require('which-key').add { { '<leader>c', group = 'CMake' } }

-- stylua: ignore start
vim.keymap.set('n', '<leader>cg', '<Cmd>CMakeGenerate<CR>', { desc = 'CMake [G]enerate' })
vim.keymap.set('n', '<leader>cb', '<Cmd>CMakeBuild<CR>', { desc = 'CMake [B]uild' })
vim.keymap.set('n', '<leader>cr', '<Cmd>CMakeRun<CR>', { desc = 'CMake [R]un' })
vim.keymap.set('n', '<leader>cd', '<Cmd>CMakeDebug<CR>', { desc = 'CMake [D]ebug' })
vim.keymap.set('n', '<leader>ct', '<Cmd>CMakeSelectBuildTarget<CR>', { desc = 'CMake select build [T]arget' })
vim.keymap.set('n', '<leader>cl', '<Cmd>CMakeSelectLaunchTarget<CR>', { desc = 'CMake select [L]aunch target' })
vim.keymap.set('n', '<leader>ck', '<Cmd>CMakeStopRunner<CR>', { desc = 'CMake [K]ill runner' })
vim.keymap.set('n', '<leader>cc', '<Cmd>CMakeClean<CR>', { desc = 'CMake [C]lean' })
-- stylua: ignore end
