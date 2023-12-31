{ pkgs }:
with pkgs.vimPlugins;
[
  telescope-nvim
  catppuccin-nvim
  neo-tree-nvim
  alpha-nvim
  harpoon
  lualine-nvim
  telescope-ui-select-nvim
  telescope-nvim

  # completion & snippets
  luasnip
  friendly-snippets
  cmp_luasnip
  cmp-nvim-lsp
  nvim-cmp
  cmp-spell

  # LSP
  mason-nvim
  mason-lspconfig-nvim
  nvim-lspconfig
  nvim-treesitter.withAllGrammars

  # formatter
  conform-nvim
] ++ [ pkgs.nixfmt pkgs.stylua ]
