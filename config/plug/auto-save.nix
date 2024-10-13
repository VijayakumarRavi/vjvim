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
          -- Disable auto-save for the harpoon plugin, otherwise it just opens and closes
          -- https://github.com/ThePrimeagen/harpoon/issues/434
          if vim.bo[buf].filetype == "harpoon" then
            return false
          end
          local fn = vim.fn
          local utils = require("auto-save.utils.data")
          -- don't save for `sql` file types
          -- I do this so when working with dadbod the file is not saved every time
          -- I make a change, and a SQL query executed
          -- Run `:set filetype?` on a dadbod query to make sure of the filetype
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
      debounce_delay = 750;
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
