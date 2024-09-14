{
  plugins.zen-mode = {
    enable = true;
    settings = {
      plugins = {
        gitsigns = {
          enabled = true;
        };
        options = {
          enabled = true;
          ruler = true;
          showcmd = true;
          laststatus = 0;
        };
        tmux = {
          enabled = true;
        };
        kitty = {
          enabled = true;
          font = "+4";
        };
      };
      window = {
        backdrop = 0.95;
        height = 1;
        options = {
          signcolumn = "no";
          relativenumber = false;
          cursorcolumn = false;
        };
        width = 0.7;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>z";
      action = ":ZenMode<CR>";
      options = {
        desc = "Toggle ZenMode";
        silent = true;
      };
    }
  ];
}
