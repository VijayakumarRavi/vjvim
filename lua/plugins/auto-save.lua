require("auto-save").setup({
  enabled = true,
  trigger_events = {
    immediate_save = { "BufLeave", "FocusLost" },
    defer_save = { "InsertLeave", "TextChanged" },
    cancel_deferred_save = { "InsertEnter" },
  },
  condition = function(buf)
    if vim.bo[buf].filetype == "harpoon" or vim.bo[buf].filetype == "oil" then
      return false
    end
    local fn = vim.fn
    local utils = require("auto-save.utils.data")
    if utils.not_in(fn.getbufvar(buf, "&filetype"), { "mysql" }) then
      return true
    end
    return false
  end,
  write_all_buffers = false,
  noautocmd = false,
  lockmarks = false,
  debounce_delay = 1000,
  debug = false,
})

local group = vim.api.nvim_create_augroup("autosave", {})
vim.api.nvim_create_autocmd("User", {
  pattern = "AutoSaveWritePost",
  group = group,
  callback = function(opts)
    if opts.data.saved_buffer ~= nil then
      print("Saved successfully at " .. vim.fn.strftime("%H:%M:%S"))
    end
  end,
})
