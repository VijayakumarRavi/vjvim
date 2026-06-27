{
  pkgs,
  inputs,
  ...
}: {
  plugins = {
    leap.enable = true;

    wakatime.enable = true;

    which-key.enable = true;

    comment.enable = true; # commenting plugin for neovim

    nvim-ufo.enable = true; # for better folding

    nvim-autopairs = {
      enable = true;
      settings = {
        event = "InsertEnter";
      };
    };

    ## automatically highlighting other uses of the word under the cursor
    illuminate = {
      enable = true;
      settings = {
        under_cursor = false;
        filetypes_denylist = [
          "Outline"
          "TelescopePrompt"
          "alpha"
          "harpoon"
          "reason"
        ];
      };
    };

    harpoon = {
      enable = true;
      enableTelescope = true;
    };

    toggleterm = {
      enable = true;
      settings = {
        direction = "float";
        float_opts = {
          border = "curved";
          height = 30;
          width = 130;
        };
        open_mapping = "[[<leader>t]]";
      };
    };
  };

  extraPlugins = [
    ## highlight the indent line
    (pkgs.vimUtils.buildVimPlugin {
      name = "hlchunk";
      src = inputs.plugin-hlchunk-nvim;
    })
    ## surround plugin
    (pkgs.vimUtils.buildVimPlugin {
      name = "visual-surround-nvim";
      src = inputs.plugin-visual-surround-nvim;
    })
    (pkgs.vimUtils.buildVimPlugin {
      name = "snipe-nvim";
      src = inputs.plugin-snipe-nvim;
    })
    (pkgs.vimUtils.buildVimPlugin {
      name = "suda-vim";
      src = inputs.plugin-suda-vim;
    })
  ];

  extraConfigLua = ''
    -- Configuration for hlchunk
    require('hlchunk').setup({
      chunk = {
        enable = false
      },
      indent = {
        enable = true
      }
    })

    -- Configuration for visual-surround-nvim
    require("visual-surround").setup({
    use_default_keymaps = false,
    })

    local prefix = "s"
    local surround_chars = { "{", "}", "[", "]", "(", ")", "'", '"', "<", "*" }
    local surround = require("visual-surround").surround
    for _, key in pairs(surround_chars) do
        vim.keymap.set("v", prefix .. key, function()
            surround(key)
        end, { desc = "[visual-surround] Surround selection with " .. key })
    end

    -- Configuration for Snipe.nvim
    local snipe = require("snipe")
    snipe.setup({
      ui = {
        max_width = -1, -- -1 means dynamic width
        position = "topright",
      },
      hints = {
        dictionary = "asdfghjklzxcvbnm",
      },
    })
    --  FIX for nvim-ufo yaml folding issue
    -- https://github.com/kevinhwang91/nvim-ufo/issues/72#issuecomment-1613900563
    -- Tell the server the capability of foldingRange,
    -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }
    local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
    for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
            capabilities = capabilities
        })
    end
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>p";
      action = ":lua require('snipe').open_buffer_menu()<CR>";
      options = {
        desc = "Toggle Snipe";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "A";
      action.__raw = "function() require('harpoon'):list():add() end";
      options = {
        desc = "Harpoon Add File";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "H";
      action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
      options = {
        desc = "Harpoon Toggle Quick Menu";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "!";
      action.__raw = "function() require('harpoon'):list():select(1) end";
      options = {
        desc = "Harpoon Select 1";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "@";
      action.__raw = "function() require('harpoon'):list():select(2) end";
      options = {
        desc = "Harpoon Select 2";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "#";
      action.__raw = "function() require('harpoon'):list():select(3) end";
      options = {
        desc = "Harpoon Select 3";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "$";
      action.__raw = "function() require('harpoon'):list():select(4) end";
      options = {
        desc = "Harpoon Select 4";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "%";
      action.__raw = "function() require('harpoon'):list():select(5) end";
      options = {
        desc = "Harpoon Select 5";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "^";
      action.__raw = "function() require('harpoon'):list():select(6) end";
      options = {
        desc = "Harpoon Select 6";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "&";
      action.__raw = "function() require('harpoon'):list():select(7) end";
      options = {
        desc = "Harpoon Select 7";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "*";
      action.__raw = "function() require('harpoon'):list():select(8) end";
      options = {
        desc = "Harpoon Select 8";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "(";
      action.__raw = "function() require('harpoon'):list():select(9) end";
      options = {
        desc = "Harpoon Select 9";
        silent = true;
      };
    }
  ];
}
