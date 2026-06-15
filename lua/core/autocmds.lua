-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Vertically center document when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  command = "norm zz",
})

-- Open help in a vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

-- Restore cursor position on opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") and vim.bo.filetype ~= "commit" and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1 then
      vim.cmd('normal! g`"')
    end
  end,
})

-- Automatically create missing directories before saving
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    local excluded_plugins = { "oil", "neo-tree", "lazy" }
    local filetype = vim.bo[args.buf].filetype
    for _, plugin in ipairs(excluded_plugins) do
      if filetype == plugin then
        return
      end
    end
    local dir = vim.fn.fnamemodify(args.file, ":p:h")
    if not vim.loop.fs_stat(dir) then
      vim.fn.mkdir(dir, "p")
    end
  end,
})
