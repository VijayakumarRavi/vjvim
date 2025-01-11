{lib, ...}: {
  plugins = {
    lsp-format = {
      enable = true;
    };

    lsp = {
      enable = true;
      servers = {
        lua_ls = {
          enable = true;
          settings.diagnostics.globals = ["vim"];
        };
        gopls = {
          enable = true;
          filetypes = ["go" "gomod" "gosum" "gotmpl" "gowork"];
          settings = {
            completeUnimported = true;
            usePlaceholders = true;
            staticcheck = true;
            analyses = {
              unusedvariable = true;
              unusedparams = true;
              unreachable = true;
            };
          };
        };
        nixd = {
          enable = true;
          settings = {
            formatting.command = ["alejandra"];
            nixpkgs.expr = "import <nixpkgs> {}";
            options = {
              zoro.expr = ''(builtins.getFlake "github:VijayakumarRavi/nix-config").nixosConfigurations.zoro.options'';
              usopp.expr = ''(builtins.getFlake "github:VijayakumarRavi/nix-config").nixosConfigurations.usopp.options'';
              nami.expr = ''(builtins.getFlake "github:VijayakumarRavi/nix-config").nixosConfigurations.nami.options'';
              kakashi.expr = ''(builtins.getFlake "github:VijayakumarRavi/nix-config").darwinConfigurations.kakashi.options'';
            };
          };
        };
        yamlls.enable = true;
        jsonls.enable = true;
        ansiblels.enable = true;
        typos_lsp.enable = true;
        dockerls.enable = true;
        docker_compose_language_service.enable = true;
      };
      keymaps = {
        silent = true;
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>cw" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        diagnostic = {
          "<leader>cd" = {
            action = "open_float";
            desc = "Line Diagnostics";
          };
          "[d" = {
            action = "goto_next";
            desc = "Next Diagnostic";
          };
          "]d" = {
            action = "goto_prev";
            desc = "Previous Diagnostic";
          };
        };
      };
    };

    ## Improves the Neovim
    lspsaga = {
      enable = true;
      beacon = {
        enable = true;
      };
      ui = {
        border = "rounded"; # One of none, single, double, rounded, solid, shadow
        codeAction = "💡"; # Can be any symbol you want 💡
      };
      hover = {
        openCmd = "!floorp"; # Choose your browser
        openLink = "gx";
      };
      diagnostic = {
        borderFollow = true;
        diagnosticOnlyCurrent = false;
        showCodeAction = true;
      };
      symbolInWinbar = {
        enable = true; # Breadcrumbs
      };
      codeAction = {
        extendGitSigns = false;
        showServerName = true;
        onlyInCursor = true;
        numShortcut = true;
        keys = {
          exec = "<CR>";
          quit = [
            "<Esc>"
            "q"
          ];
        };
      };
      lightbulb = {
        enable = false;
        sign = false;
        virtualText = true;
      };
      implement = {
        enable = false;
      };
      rename = {
        autoSave = false;
        keys = {
          exec = "<CR>";
          quit = [
            "<C-k>"
            "<Esc>"
          ];
          select = "x";
        };
      };
      outline = {
        autoClose = true;
        autoPreview = true;
        closeAfterJump = true;
        layout = "normal"; # normal or float
        winPosition = "right"; # left or right
        keys = {
          jump = "e";
          quit = "q";
          toggleOrJump = "o";
        };
      };
      scrollPreview = {
        scrollDown = "<C-f>";
        scrollUp = "<C-b>";
      };
    };

    ## Fidget for Neovim notifications and LSP progress messages.
    fidget = {
      enable = true;
      settings = {
        logger = {
          level = "warn"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
          float_precision = 1.0e-2; # Limit the number of decimals displayed for floats
        };
        progress = {
          poll_rate = 0; # How and when to poll for progress messages
          suppress_on_insert = true; # Suppress new messages while in insert mode
          ignore_done_already = false; # Ignore new tasks that are already complete
          ignore_empty_message = false; # Ignore new tasks that don't contain a message
          # Clear notification group when LSP server detaches
          clear_on_detach = lib.nixvim.mkRaw ''
            function(client_id)
              local client = vim.lsp.get_client_by_id(client_id)
              return client and client.name or nil
            end
          '';
          # How to get a progress message's notification group key
          notification_group = lib.nixvim.mkRaw ''
            function(msg) return msg.lsp_client.name end
          '';
          ignore = []; # List of LSP servers to ignore
          lsp = {
            progress_ringbuf_size = 0; # Configure the nvim's LSP progress ring buffer size
          };
          display = {
            render_limit = 16; # How many LSP messages to show at once
            done_ttl = 3; # How long a message should persist after completion
            done_icon = "✔"; # Icon shown when all LSP progress tasks are complete
            done_style = "Constant"; # Highlight group for completed LSP tasks
            progress_ttl = lib.nixvim.mkRaw "math.huge"; # How long a message should persist when in progress
            progress_icon = {
              pattern = "dots";
              period = 1;
            }; # Icon shown when LSP progress tasks are in progress
            progress_style = "WarningMsg"; # Highlight group for in-progress LSP tasks
            group_style = "Title"; # Highlight group for group name (LSP server name)
            icon_style = "Question"; # Highlight group for group icons
            priority = 30; # Ordering priority for LSP notification group
            skip_history = true; # Whether progress notifications should be omitted from history
            # How to format a progress message
            format_message = ''
              require ("fidget.progress.display").default_format_message
            ''; # How to format a progress annotation
            format_annote = ''
              function (msg) return msg.title end
            ''; # How to format a progress notification group's name
            format_group_name = ''
              function (group) return tostring (group) end
            ''; # Override options from the default notification config
            overrides = {
              rust_analyzer = {
                name = "rust-analyzer";
              };
            };
          };
        };
        notification = {
          poll_rate = 10; # How frequently to update and render notifications
          filter = "info"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
          history_size = 128; # Number of removed messages to retain in history
          override_vim_notify = true;
          redirect = lib.nixvim.mkRaw ''
            function(msg, level, opts)
              if opts and opts.on_open then
                return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
              end
            end
          '';
          configs.default = lib.nixvim.mkRaw "require(\"fidget.notification\").default_config";

          window = {
            normal_hl = "Comment";
            winblend = 0;
            border = "none"; # none, single, double, rounded, solid, shadow
            zindex = 45;
            max_width = 0;
            max_height = 0;
            x_padding = 1;
            y_padding = 0;
            align = "bottom";
            relative = "editor";
          };
          view = {
            stack_upwards = true; # Display notification items from bottom to top
            icon_separator = " "; # Separator between group name and icon
            group_separator = "---"; # Separator between notification groups
            group_separator_hl =
              # Highlight group used for group separator
              "Comment";
          };
        };
      };
    };
  };

  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
  '';

  keymaps = [
    {
      mode = "n";
      key = "gd";
      action = "<cmd>Lspsaga finder def<CR>";
      options = {
        desc = "Goto Definition";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gr";
      action = "<cmd>Lspsaga finder ref<CR>";
      options = {
        desc = "Goto References";
        silent = true;
      };
    }

    # {
    #   mode = "n";
    #   key = "gD";
    #   action = "<cmd>Lspsaga show_line_diagnostics<CR>";
    #   options = {
    #     desc = "Goto Declaration";
    #     silent = true;
    #   };
    # }

    {
      mode = "n";
      key = "gI";
      action = "<cmd>Lspsaga finder imp<CR>";
      options = {
        desc = "Goto Implementation";
        silent = true;
      };
    }

    {
      mode = "n";
      key = "gT";
      action = "<cmd>Lspsaga peek_type_definition<CR>";
      options = {
        desc = "Type Definition";
        silent = true;
      };
    }

    {
      mode = "n";
      key = "K";
      action = "<cmd>Lspsaga hover_doc<CR>";
      options = {
        desc = "Hover";
        silent = true;
      };
    }

    {
      mode = "n";
      key = "<leader>cw";
      action = "<cmd>Lspsaga outline<CR>";
      options = {
        desc = "Outline";
        silent = true;
      };
    }

    {
      mode = "n";
      key = "<leader>cr";
      action = "<cmd>Lspsaga rename<CR>";
      options = {
        desc = "Rename";
        silent = true;
      };
    }

    {
      mode = "n";
      key = "<leader>ca";
      action = "<cmd>Lspsaga code_action<CR>";
      options = {
        desc = "Code Action";
        silent = true;
      };
    }

    {
      mode = "n";
      key = "<leader>cd";
      action = "<cmd>Lspsaga show_line_diagnostics<CR>";
      options = {
        desc = "Line Diagnostics";
        silent = true;
      };
    }

    {
      mode = "n";
      key = "[d";
      action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
      options = {
        desc = "Next Diagnostic";
        silent = true;
      };
    }

    {
      mode = "n";
      key = "]d";
      action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
      options = {
        desc = "Previous Diagnostic";
        silent = true;
      };
    }
  ];
}
