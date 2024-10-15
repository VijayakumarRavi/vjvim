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
      underCursor = false;
      filetypesDenylist = [
        "Outline"
        "TelescopePrompt"
        "alpha"
        "harpoon"
        "reason"
      ];
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
      src = inputs.Plugin-hlchunk-nvim;
    })
    ## surround plugin
    (pkgs.vimUtils.buildVimPlugin {
      name = "visual-surround-nvim";
      src = inputs.Plugin-visual-surround-nvim;
    })
    (pkgs.vimUtils.buildVimPlugin {
      name = "snipe-nvim";
      src = inputs.Plugin-snipe-nvim;
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
  ];
}
