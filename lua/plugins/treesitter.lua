
-- Enable Treesitter highlighting
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*' },
  callback = function() pcall(vim.treesitter.start) end,
})

-- Autotag
require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false
  }
})

-- Text objects
require("nvim-treesitter-textobjects").setup({
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
    },
  },
})

require("treesitter-context").setup({})
