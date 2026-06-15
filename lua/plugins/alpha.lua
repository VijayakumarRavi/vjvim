local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "                                                                       ",
  "                                                                       ",
  "                                                                       ",
  "                                                                       ",
  "                                                                     ",
  "       ████ ██████           █████      ██                     ",
  "      ███████████             █████                             ",
  "      █████████ ███████████████████ ███   ███████████   ",
  "     █████████  ███    █████████████ █████ ██████████████   ",
  "    █████████ ██████████ █████████ █████ █████ ████ █████   ",
  "  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
  " ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
  "                                                                       ",
  "                                                                       ",
  "                                                                       ",
}
dashboard.section.header.opts.hl = "AlphaHeader"

dashboard.section.buttons.val = {
  dashboard.button("n", "  New file", "<cmd>ene<CR>"),
  dashboard.button("f", "  Browse File", "<cmd>lua if vim.fn.argc() == 0 then require('telescope').extensions['frecency'].frecency({prompt_prefix='  '}) end<CR>"),
  dashboard.button("p", "  Projects", "<cmd>lua require('telescope').extensions.projects.projects{}<CR>"),
  dashboard.button("g", "  Open LazyGit", "<cmd>LazyGit<CR>"),
  dashboard.button("q", "  Quit Neovim", "<cmd>qa<CR>"),
}

dashboard.section.footer.val = { "https://github.com/vijayakumarravi/vjvim" }
dashboard.section.footer.opts.hl = "GruvboxBlue"

dashboard.config.layout = {
  { type = "padding", val = 4 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  { type = "padding", val = 2 },
  dashboard.section.footer,
}

alpha.setup(dashboard.config)
