{
  ### Git signs
  plugins = {
    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add = {
            text = "│";
          };
          change = {
            text = "│";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          changedelete = {
            text = "~";
          };
          untracked = {
            text = "│";
          };
        };
      };
    };

    ## Git worktree
    git-worktree = {
      enable = true;
      enableTelescope = true;
    };

    ## Lazy git
    lazygit = {
      enable = true;
    };
  };

  ## Lazy git
  extraConfigLua = ''
    require("telescope").load_extension("lazygit")
  '';

  keymaps = [
    ## Lazy git
    {
      mode = "n";
      key = "<leader>g";
      action = "<cmd>LazyGit<CR>";
      options = {
        desc = "LazyGit (root dir)";
      };
    }
    {
      mode = ["n" "v"];
      key = "<leader>gh";
      action = ":Gitsigns toggle_current_line_blame<CR>";
      options = {
        silent = true;
        desc = "+hunks";
      };
    }
    {
      mode = "n";
      key = "<leader>ghb";
      action = ":Gitsigns blame_line<CR>";
      options = {
        silent = true;
        desc = "Blame line";
      };
    }
    {
      mode = "n";
      key = "<leader>ghd";
      action = ":Gitsigns diffthis<CR>";
      options = {
        silent = true;
        desc = "Diff This";
      };
    }
    {
      mode = "n";
      key = "<leader>ghR";
      action = ":Gitsigns reset_buffer<CR>";
      options = {
        silent = true;
        desc = "Reset Buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>ghS";
      action = ":Gitsigns stage_buffer<CR>";
      options = {
        silent = true;
        desc = "Stage Buffer";
      };
    }
  ];
}
