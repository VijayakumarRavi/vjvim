-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
vim.diagnostic.config {
	update_in_insert = false,
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = true,
	virtual_lines = false,
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float { bufnr = bufnr, scope = 'cursor', focus = false }
		end,
	},
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', { silent = true })

-- Control+s to save
vim.keymap.set('n', '<c-s>', ':w<CR>', { silent = true })
vim.keymap.set({ 'i', 'v' }, '<c-s>', '<esc>:w<CR>', { silent = true })

-- Control+q to save and quit
vim.keymap.set('n', '<c-q>', ':wq<CR>', { silent = true })
vim.keymap.set({ 'i', 'v' }, '<c-q>', '<esc>:wq<CR>', { silent = true })

-- Sudo save
vim.keymap.set("c", "w!!", "w !sudo tee > /dev/null %", { desc = "Save with sudo" })

-- ============================================================================
-- PLUGIN KEYBINDS
-- ============================================================================

-- Telescope
vim.keymap.set("n", "<leader>fh", function() require("telescope.builtin").help_tags() end,
	{ desc = "[F]ind [H]elp Tags" })
vim.keymap.set("n", "<leader>fk", function() require("telescope.builtin").keymaps() end, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fs", function() require("telescope.builtin").builtin() end, { desc = "[F]ind [S]earch" })
vim.keymap.set("n", "<leader>fw", function() require("telescope.builtin").grep_string() end, { desc = "[F]ind [W]ord" })
vim.keymap.set("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "[F]ind [G]rep" })
vim.keymap.set("n", "<leader>fd", function() require("telescope.builtin").diagnostics() end,
	{ desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fr", function() require("telescope.builtin").resume() end, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>f.", function() require("telescope.builtin").oldfiles() end,
	{ desc = '[F]ind [.] Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", function() require("telescope.builtin").find_files() end,
	{ desc = "[ ] Find Files" })

-- LSP (Functions dynamically attach when LSP starts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, desc = "Goto Definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true, desc = "Goto References" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, desc = "Goto Declaration" })
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { silent = true, desc = "Goto Implementation" })
vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { silent = true, desc = "Type Definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, desc = "Hover" })
vim.keymap.set("n", "<leader>cw", vim.lsp.buf.workspace_symbol, { silent = true, desc = "Workspace Symbol" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { silent = true, desc = "Rename" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { silent = true, desc = "Line Diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { silent = true, desc = "Next Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { silent = true, desc = "Previous Diagnostic" })

-- Git
vim.keymap.set({ "n", "v" }, "<leader>gh", "<cmd>Gitsigns toggle_current_line_blame<CR>",
	{ silent = true, desc = "+hunks" })
vim.keymap.set("n", "<leader>ghb", "<cmd>Gitsigns blame_line<CR>", { silent = true, desc = "Blame line" })
vim.keymap.set("n", "<leader>ghd", "<cmd>Gitsigns diffthis<CR>", { silent = true, desc = "Diff This" })
vim.keymap.set("n", "<leader>ghR", "<cmd>Gitsigns reset_buffer<CR>", { silent = true, desc = "Reset Buffer" })
vim.keymap.set("n", "<leader>ghS", "<cmd>Gitsigns stage_buffer<CR>", { silent = true, desc = "Stage Buffer" })
vim.keymap.set("n", "<leader>gw", function() require('telescope').extensions.git_worktree.git_worktrees() end,
	{ desc = "Git Worktrees" })
vim.keymap.set("n", "<leader>gwc", function() require('telescope').extensions.git_worktree.create_git_worktree() end,
	{ desc = "Create Git Worktree" })
vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<CR>", { desc = "LazyGit (root dir)" })

-- Leap
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

-- UFO (Folding)
vim.keymap.set('n', 'zR', function() require('ufo').openAllFolds() end, { desc = "Open all folds" })
vim.keymap.set('n', 'zM', function() require('ufo').closeAllFolds() end, { desc = "Close all folds" })
vim.keymap.set('n', 'za', 'za', { desc = "Toggle fold" })

-- Harpoon
vim.keymap.set("n", "A", function() require("harpoon.mark").add_file() end, { silent = true })
vim.keymap.set("n", "H", function() require("harpoon.ui").toggle_quick_menu() end, { silent = true })
vim.keymap.set("n", "!", function() require("harpoon.ui").nav_file(1) end, { silent = true })
vim.keymap.set("n", "@", function() require("harpoon.ui").nav_file(2) end, { silent = true })
vim.keymap.set("n", "#", function() require("harpoon.ui").nav_file(3) end, { silent = true })
vim.keymap.set("n", "$", function() require("harpoon.ui").nav_file(4) end, { silent = true })
vim.keymap.set("n", "%", function() require("harpoon.ui").nav_file(5) end, { silent = true })
vim.keymap.set("n", "^", function() require("harpoon.ui").nav_file(6) end, { silent = true })
vim.keymap.set("n", "&", function() require("harpoon.ui").nav_file(7) end, { silent = true })
vim.keymap.set("n", "*", function() require("harpoon.ui").nav_file(8) end, { silent = true })
vim.keymap.set("n", "(", function() require("harpoon.ui").nav_file(9) end, { silent = true })

-- Visual Surround
for _, key in ipairs({ "{", "}", "[", "]", "(", ")", "'", '"', "<", "*" }) do
	vim.keymap.set("v", "s" .. key, function() require("visual-surround").surround(key) end,
		{ desc = "Surround with " .. key })
end

-- Snipe
vim.keymap.set("n", "<leader>p", function() require("snipe").open_buffer_menu() end,
	{ silent = true, desc = "Toggle Snipe" })

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Zen Mode
vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { silent = true, desc = "Toggle ZenMode" })

-- Nvim-Tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
