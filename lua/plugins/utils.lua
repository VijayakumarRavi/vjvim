

require("which-key").setup({})

require("Comment").setup()

require("ufo").setup()


require("nvim-autopairs").setup({})

require("illuminate").configure({
	under_cursor = false,
	filetypes_denylist = { "Outline", "TelescopePrompt", "alpha", "harpoon", "reason" },
})

local harpoon = require("harpoon")
harpoon.setup({})
require("telescope").load_extension("harpoon")


require("toggleterm").setup({
	direction = "float",
	float_opts = { border = "curved", height = 30, width = 130 },
	open_mapping = "[[<leader>t]]",
})

require("hlchunk").setup({ chunk = { enable = false }, indent = { enable = true } })

require("visual-surround").setup({ use_default_keymaps = false })
local surround = require("visual-surround").surround


require("snipe").setup({ ui = { max_width = -1, position = "topright" }, hints = { dictionary = "asdfghjklzxcvbnm" } })
