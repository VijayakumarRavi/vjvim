local opts = { silent = true }

return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim", -- don't forget to add this one if you don't have it yet!
  },
  config = function()
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

    vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
    vim.cmd("highlight! HarpoonActive guibg=NONE guifg=black")
    vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
    vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
    vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
  end
}
