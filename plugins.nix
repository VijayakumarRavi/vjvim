{ pkgs }:
with pkgs.vimPlugins; [
  telescope-nvim
  catppuccin-nvim
  neo-tree-nvim
  harpoon
  mason-nvim
  mason-lspconfig-nvim
  nvim-lspconfig
  lualine-nvim
  telescope-ui-select-nvim
  telescope-nvim
  nvim-treesitter.withAllGrammars
]
