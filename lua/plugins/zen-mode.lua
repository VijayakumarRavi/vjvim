require("zen-mode").setup({
  plugins = {
    gitsigns = { enabled = true },
    options = { enabled = true, ruler = true, showcmd = true, laststatus = 0 },
    tmux = { enabled = true },
    kitty = { enabled = true, font = "+4" },
  },
  window = {
    backdrop = 0.95,
    height = 1,
    width = 0.7,
    options = { signcolumn = "no", relativenumber = false, cursorcolumn = false },
  },
})
