-- Sync clipboard between OS and Neovim.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Set <space> as the leader key
vim.g.mapleader          = ' '
vim.g.maplocalleader     = ' '
vim.g.have_nerd_font     = true -- Assuming true based on the previous config having many icons

-- Disabling netrw in faveor of nvim-tree.lua
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors    = true

-- Make line numbers default
vim.o.number             = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse              = 'a'
-- Don't show the mode, since it's already in the status line
vim.o.showmode           = false

vim.o.tabstop            = 2

-- Enable break indent
vim.o.breakindent        = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile           = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase         = true
vim.o.smartcase          = true

-- Keep signcolumn on by default
vim.o.signcolumn         = 'yes'

-- Decrease update time
vim.o.updatetime         = 250
vim.o.timeoutlen         = 300

-- Configure how new splits should be opened
vim.o.splitright         = true
vim.o.splitbelow         = true

vim.o.list               = true
vim.opt.listchars        = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand         = 'split'

-- Show which line your cursor is on
vim.o.cursorline         = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff          = 10
vim.o.cc                 = '80'

-- Confirm on unsaved changes
vim.o.confirm            = true

-- nvim-ufo folding settings
vim.o.foldcolumn         = '1'
vim.o.foldlevel          = 99
vim.o.foldlevelstart     = 99
vim.o.foldenable         = true
