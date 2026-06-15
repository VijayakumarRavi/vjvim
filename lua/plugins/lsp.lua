
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})
vim.lsp.enable('lua_ls')

vim.lsp.config('gopls', {
  filetypes = { "go", "gomod", "gosum", "gotmpl", "gowork" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
      analyses = {
        unusedvariable = true,
        unusedparams = true,
        unreachable = true,
      },
    },
  },
})
vim.lsp.enable('gopls')

vim.lsp.config('nixd', {
  settings = {
    nixd = {
      formatting = { command = { "alejandra" } },
      nixpkgs = { expr = "import <nixpkgs> { }" },
      options = {
        zoro = { expr = '(builtins.getFlake "github:VijayakumarRavi/nix-config").nixosConfigurations.zoro.options' },
        usopp = { expr = '(builtins.getFlake "github:VijayakumarRavi/nix-config").nixosConfigurations.usopp.options' },
        nami = { expr = '(builtins.getFlake "github:VijayakumarRavi/nix-config").nixosConfigurations.nami.options' },
        kakashi = { expr = '(builtins.getFlake "github:VijayakumarRavi/nix-config").darwinConfigurations.kakashi.options' },
      },
    },
  },
})
vim.lsp.enable('nixd')

vim.lsp.config('yamlls', {})
vim.lsp.enable('yamlls')

vim.lsp.config('ansiblels', {})
vim.lsp.enable('ansiblels')

vim.lsp.config('typos_lsp', {})
vim.lsp.enable('typos_lsp')

vim.lsp.config('dockerls', {})
vim.lsp.enable('dockerls')

vim.lsp.config('docker_compose_language_service', {})
vim.lsp.enable('docker_compose_language_service')

require("lspsaga").setup({
  beacon = { enable = true },
  ui = { border = "rounded", code_action = "💡" },
  hover = { open_cmd = "!floorp", open_link = "gx" },
  diagnostic = { border_follow = true, show_code_action = true, diagnostic_only_current = false },
  symbol_in_winbar = { enable = true },
  code_action = { show_server_name = true, extend_gitsigns = false, only_in_cursor = true, num_shortcut = true, keys = { exec = "<CR>", quit = { "<Esc>", "q" } } },
  lightbulb = { enable = false, sign = false, virtual_text = true },
  implement = { enable = false },
  rename = { auto_save = false, keys = { exec = "<CR>", quit = { "<C-k>", "<Esc>" }, select = "x" } },
  outline = { auto_close = true, auto_preview = true, close_after_jump = true, layout = "normal", win_position = "right" },
})
