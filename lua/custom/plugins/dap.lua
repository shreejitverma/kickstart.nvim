-- Debugging (DAP). Reuse kickstart's maintained debug module rather than
-- duplicating it, then add adapters for the languages used here (C/C++/Rust
-- via codelldb, Python via debugpy). The mason packages (codelldb, debugpy)
-- are installed via the ensure_installed list in init.lua.
--
-- Keymaps (from kickstart): <F5> continue · <F1/2/3> step into/over/out
--   <leader>b toggle breakpoint · <leader>B conditional breakpoint
--   <F7> toggle dap-ui
require 'kickstart.plugins.debug'

local dap = require 'dap'
local mason_bin = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'bin')
local mason_pkg = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'packages')

-- C / C++ / Rust via codelldb
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fs.joinpath(mason_bin, 'codelldb'),
    args = { '--port', '${port}' },
  },
}

local codelldb_cfg = {
  {
    name = 'Launch (codelldb)',
    type = 'codelldb',
    request = 'launch',
    program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file') end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.cpp = codelldb_cfg
dap.configurations.c = codelldb_cfg
dap.configurations.rust = codelldb_cfg

-- Python via debugpy (nvim-dap-python wraps it with sensible configurations)
vim.pack.add { 'https://github.com/mfussenegger/nvim-dap-python' }
local debugpy_python = vim.fs.joinpath(mason_pkg, 'debugpy', 'venv', 'bin', 'python')
require('dap-python').setup(vim.uv.fs_stat(debugpy_python) and debugpy_python or 'python3')

-- JavaScript / TypeScript via js-debug-adapter (vscode-js-debug)
dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = { vim.fs.joinpath(mason_pkg, 'js-debug-adapter', 'js-debug', 'src', 'dapDebugServer.js'), '${port}' },
  },
}
for _, lang in ipairs { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' } do
  dap.configurations[lang] = {
    { type = 'pwa-node', request = 'launch', name = 'Launch file', program = '${file}', cwd = '${workspaceFolder}' },
    { type = 'pwa-node', request = 'attach', name = 'Attach to process', processId = require('dap.utils').pick_process, cwd = '${workspaceFolder}' },
  }
end

-- Go DAP is provided by nvim-dap-go (loaded via kickstart.plugins.debug) + delve.
-- Rust DAP reuses the codelldb configuration defined above.
