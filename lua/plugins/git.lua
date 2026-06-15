require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "│" },
	},
})


local ok, gw = pcall(require, "git-worktree")
if ok and gw.setup then
	gw.setup({})
end
require("telescope").load_extension("git_worktree")


require("telescope").load_extension("lazygit")
