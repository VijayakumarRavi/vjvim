require("rose-pine").setup({
  styles = {
    transparency = true,
  },
})

require("tokyonight").setup({
  style = "night",
  transparent = false,
  on_highlights = function(hl, c)
    local prompt = "#2d3149"
    hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
    hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
    hl.TelescopePromptNormal = { bg = prompt }
    hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
    hl.TelescopePromptTitle = { bg = prompt, fg = prompt }
    hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
    hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
  end,
})

vim.cmd("colorscheme rose-pine-main")
