{
  plugins = {
    leap.enable = true;

    nvim-autopairs = {
      enable = true;
    };

    ## commenting plugin for neovim
    comment = {
      enable = true;
    };

    ## automatically highlighting other uses of the word under the cursor
    illuminate = {
      enable = true;
      underCursor = false;
      filetypesDenylist = [
        "Outline"
        "TelescopePrompt"
        "alpha"
        "harpoon"
        "reason"
      ];
    };

    undotree = {
      enable = true;
      settings = {
        autoOpenDiff = true;
        focusOnToggle = true;
      };
    };

    harpoon = {
      enable = true;
      enableTelescope = true;
      keymapsSilent = true;
      keymaps = {
        addFile = "A";
        toggleQuickMenu = "H";
        navFile = {
          "1" = "!";
          "2" = "@";
          "3" = "#";
          "4" = "$";
          "5" = "%";
          "6" = "^";
          "7" = "&";
          "8" = "*";
          "9" = "(";
        };
      };
    };
  };

  keymaps = [
    {
      ## undo tree
      mode = "n";
      key = "<leader>ut";
      action = "<cmd>UndotreeToggle<CR>";
      options = {
        silent = true;
        desc = "Undotree";
      };
    }
  ];
}
