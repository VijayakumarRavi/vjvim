{
  plugins.auto-save = {
    enable = true;
    settings = {
      enabled = true;
      trigger_events = {
        immediate_save = ["BufLeave" "FocusLost"];
        defer_save = ["InsertLeave" "TextChanged"]; ## vim events that trigger a deferred save (saves after `debounce_delay`)
        cancel_deferred_save = ["InsertEnter"]; ## vim events that cancel a pending deferred save
      };
      condition = ''
          function(buf)
          if vim.bo[buf].filetype == "harpoon" or vim.bo[buf].filetype == "oil" then
            return false
          end
          local fn = vim.fn
          local utils = require("auto-save.utils.data")
          if utils.not_in(fn.getbufvar(buf, "&filetype"), { "mysql" }) then
            return true
          end
          return false
        end
      '';
      write_all_buffers = false; ## write all buffers when the current one meets `condition`
      ## Do not execute autocmds when saving
      ## This is what fixed the issues with undo/redo that I had
      ## https://github.com/okuuva/auto-save.nvim/issues/55
      ## Issue in original plugin
      ## https://github.com/pocco81/auto-save.nvim/issues/70
      noautocmd = false;
      lockmarks = false; ## lock marks when saving, see `:h lockmarks` for more details
      ## delay after which a pending save is executed (default 1000)
      debounce_delay = 1000;
      ## log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
      debug = false;
    };
  };

  ## Add the following code to set up the autocommand for printing the message
  extraConfigLua = ''
    local group = vim.api.nvim_create_augroup("autosave", {})

    vim.api.nvim_create_autocmd("User", {
      pattern = "AutoSaveWritePost",
      group = group,
      callback = function(opts)
        if opts.data.saved_buffer ~= nil then
          print("Saved successfully at " .. vim.fn.strftime("%H:%M:%S"))
        end
      end,
    })'';
}
