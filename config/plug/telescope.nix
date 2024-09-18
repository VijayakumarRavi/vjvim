{pkgs, ...}: {
  plugins = {
    telescope = {
      enable = true;
      extensions = {
        frecency = {
          enable = true;
          settings.show_scores = true;
        };
        fzf-native = {
          enable = true;
        };
        undo = {
          enable = true;
          settings = {
            side_by_side = true;
            time_format = "!%Y-%m-%dT%TZ";
            use_custom_command = [
              "bash"
              "-c"
              "echo '$DIFF' | delta"
            ];
            entry_format = "state #$ID";
            use_delta = true;
            vim_diff_opts = {
              ctxlen = 8;
            };
          };
        };
      };
      settings = {
        defaults = {
          layout_config = {
            horizontal = {
              prompt_position = "top";
            };
          };
          sorting_strategy = "ascending";
          prompt_prefix = "  ";
        };
      };
      keymaps = {
        "<leader><space>" = {
          action = "frecency workspace=CWD";
          options = {
            desc = "Find files";
          };
        };
        "<leader>/" = {
          action = "live_grep prompt_prefix=🔍 ";
          options = {
            desc = "Grep (root dir)";
          };
        };
        "<leader>u" = {
          action = "undo";
          options = {
            desc = "undo tree";
          };
        };
        "<leader>:" = {
          action = "command_history";
          options = {
            desc = "Command History";
          };
        };
        "<leader>b" = {
          action = "buffers";
          options = {
            desc = "+buffer";
          };
        };
        "<leader>ff" = {
          action = "oldfiles";
          options = {
            desc = "Recent files";
          };
        };
        "<leader>fg" = {
          action = "git_files";
          options = {
            desc = "Search git files";
          };
        };
        "<leader>gc" = {
          action = "git_commits";
          options = {
            desc = "Commits";
          };
        };
        "<leader>sd" = {
          action = "diagnostics";
          options = {
            desc = "Workspace diagnostics";
          };
        };
        "<leader>sh" = {
          action = "help_tags";
          options = {
            desc = "Help pages";
          };
        };
        "<leader>k" = {
          action = "keymaps";
          options = {
            desc = "Keymaps";
          };
        };
        "<C-p>" = {
          action = "projects";
          options = {
            desc = "Find project files";
          };
        };
      };
    };
    ## project management
    project-nvim = {
      enable = true;
      enableTelescope = true;
    };
  };

  extraPackages = [pkgs.ripgrep];
}
