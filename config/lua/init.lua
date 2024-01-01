-- catppuccin theme
vim.cmd.colorscheme("catppuccin")

-- alpha dashboard

local alpha = require("alpha")
local startify = require("alpha.themes.startify")

startify.section.header.val = {
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                     ]],
  [[       ████ ██████           █████      ██                     ]],
  [[      ███████████             █████                             ]],
  [[      █████████ ███████████████████ ███   ███████████   ]],
  [[     █████████  ███    █████████████ █████ ██████████████   ]],
  [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
  [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
  [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
}

--_Gopts = {
--  position = "center",
--  hl = "Type",
--  -- wrap = "overflow";
--}

startify.opts.opts.position = "center"
-- startify.section.footer.val = footer()

startify.opts.opts.noautocmd = true
alpha.setup(startify.opts)

-- Harpoon keymaps
vim.keymap.set("n", "A", ':lua require("harpoon.mark").add_file()<CR>', {})
vim.keymap.set("n", "R", ':lua require("harpoon.mark").clear_all()<CR>', {})
vim.keymap.set("n", "H", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', {})
vim.keymap.set("n", "J", ':lua require("harpoon.ui").nav_next()<CR>', {})
vim.keymap.set("n", "K", ':lua require("harpoon.ui").nav_prev()<CR>', {})
vim.keymap.set("n", "!", ':lua require("harpoon.ui").nav_file(1)<CR>', {})
vim.keymap.set("n", "@", ':lua require("harpoon.ui").nav_file(2)<CR>', {})
vim.keymap.set("n", "#", ':lua require("harpoon.ui").nav_file(3)<CR>', {})
vim.keymap.set("n", "$", ':lua require("harpoon.ui").nav_file(4)<CR>', {})
vim.keymap.set("n", "%", ':lua require("harpoon.ui").nav_file(5)<CR>', {})
vim.keymap.set("n", "^", ':lua require("harpoon.ui").nav_file(6)<CR>', {})
vim.keymap.set("n", "&", ':lua require("harpoon.ui").nav_file(7)<CR>', {})
vim.keymap.set("n", "*", ':lua require("harpoon.ui").nav_file(8)<CR>', {})
vim.keymap.set("n", "(", ':lua require("harpoon.ui").nav_file(9)<CR>', {})
-- Harpoon colors
vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
vim.cmd("highlight! HarpoonActive guibg=NONE guifg=black")
vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")

-- mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "nil_ls", "rust_analyzer" },
  automatic_installation = true,
})
-- lspconfig
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup({
  capabilites = capabilities,
})
lspconfig.nil_ls.setup({
  capabilites = capabilities,
})
lspconfig.rust_analyzer.setup({
  capabilites = capabilities,
})

-- lsp keymaps
vim.keymap.set("n", "<C-h>", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

-- lualine
require("lualine").setup({
  options = {
    theme = "catppuccin",
  },
})

--  neotree
vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", {})
vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})

-- telescope keymaps & setup
require("telescope").setup({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

require("telescope").load_extension("ui-select")
require("telescope").load_extension("harpoon")

-- treesitter

local config = require("nvim-treesitter.configs")
config.setup({
  -- ensure_installed = {"lua", "javascript", "nix"},
  highlight = { enable = true },
  indent = { enable = true },
})

-- Conform will formate code on write
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixfmt" },
    terraform = { "terraform_fmt" },
  },
  format_on_save = {
    -- I recommend these options. See :help conform.format for details.
    lsp_fallback = true,
    timeout_ms = 500,
  },
})

-- completion config

require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
cmp.setup({
  window = {
    documentation = cmp.config.window.bordered(),
    completion = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    {
      name = 'spell',
      option = {
        keep_all_entries = false,
        enable_in_context = function()
          return true
        end,
      },
    },
  }, {
    { name = "buffer" },
  }),
})

-- Diff view
require("diffview").setup({
  enhanced_diff_hl = true,             -- See ':h diffview-config-enhanced_diff_hl'
  file_panel = {
    listing_style = "tree",            -- One of 'list' or 'tree'
    tree_options = {                   -- Only applies when listing_style is 'tree'
      flatten_dirs = true,             -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
    },
    win_config = {                     -- See ':h diffview-config-win_config'
      position = "left",
      width = 25,
      win_opts = {}
    },
  },
})

vim.keymap.set("n", "<C-d>", ":DiffviewOpen<CR>")
vim.keymap.set("n", "<C-t>", ":tabclose<CR>")
vim.keymap.set("n", "<S-t>", ":tabnew<CR>")

-- vim options
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set autoindent")
vim.cmd("set smartindent")
vim.cmd("set clipboard=unnamedplus ")
vim.cmd("set nohlsearch")
vim.cmd("set incsearch")
vim.cmd("set ignorecase")
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.wo.number = true
vim.wo.relativenumber = true

vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- ease of use saveing
vim.keymap.set("i", "<c-s>", "<esc>:w<cr>")
vim.keymap.set("n", "<c-s>", ":w<cr>")

-- last cursor position
-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler,
-- for a commit or rebase message
-- (likely a different one than last time), and when using xxd(1) to filter
-- and edit binary files (it transforms input files back and forth, causing
-- them to have dual nature, so to speak)
function RestoreCursorPosition()
  local line = vim.fn.line("'\"")
  if
      line > 1
      and line <= vim.fn.line("$")
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
  then
    vim.cmd('normal! g`"')
  end
end

if vim.fn.has("autocmd") then
  vim.cmd([[
    autocmd BufReadPost * lua RestoreCursorPosition()
  ]])
end

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
