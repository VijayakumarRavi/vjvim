{ pkgs }:
with pkgs.vimPlugins;
[
  # UI
  alpha-nvim
  lualine-nvim
  catppuccin-nvim

  # File explorer & fuzzy finders
  harpoon
  neo-tree-nvim
  telescope-nvim
  telescope-ui-select-nvim

  # Utils
  vim-wakatime
  diffview-nvim

  # Completion & snippets
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

  # Formatter
  conform-nvim
] ++ [ pkgs.nixfmt pkgs.stylua ]
