{ pkgs }:
with pkgs.vimPlugins;
[
  # UI
  alpha-nvim
  lualine-nvim
  catppuccin-nvim

  # file explorer & fuzzy finders
  harpoon
  neo-tree-nvim
  telescope-nvim
  telescope-ui-select-nvim

  # usage tracker
  vim-wakatime

  # completion & snippets
  luasnip
  nvim-cmp
  cmp-spell
  cmp_luasnip
  cmp-nvim-lsp
  friendly-snippets

  # LSP
  mason-nvim
  nvim-lspconfig
  mason-lspconfig-nvim
  nvim-treesitter.withAllGrammars

  # formatter
  conform-nvim
] ++ [ pkgs.nixfmt pkgs.stylua ]
