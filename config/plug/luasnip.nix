{pkgs, ...}: {
  plugins.luasnip = {
    enable = true;
    settings = {
      enable_autosnippets = true;
      store_selection_keys = "<Tab>";
    };
    fromVscode = [
      {
        lazyLoad = true;
        paths = "${pkgs.vimPlugins.friendly-snippets}";
      }
    ];
  };

  extraConfigLua = ''
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    -- NixOS Module Declaration
    ls.add_snippets("nix", {
      s("{}", {
        t({"{"}),
        t({"","  config,"}),
        t({"","  lib,"}),
        t({"","  pkgs,"}),
        t({"","  ..."}),
        t({"","}: {"}),
        t({"", "  "}), i(1, ""),
        t({"", " "}),
      }),
    })

    -- Function to insert a snippet template
    -- https://github.com/voyeg3r/nvim/blob/e80df68beece2165fa1afbb1bc590650a66eb302/lua/core/utils.lua#L231
    insert_snippet_template = function(snip_name)
      local snips = require('luasnip').get_snippets()[vim.bo.filetype]
      if snips then
        for _, snip in ipairs(snips) do
          if snip['name'] == snip_name then
            require('luasnip').snip_expand(snip)
            return true
          end
        end
      end
      return false
    end

    -- Set up an autocommand to automatically insert a LuaSnip snippet on new file creation
    vim.api.nvim_create_autocmd("BufNewFile", {
      pattern = "*.nix",  -- Trigger this on new .nix files
      callback = function()
         if vim.fn.line('$') ~= 1 or vim.fn.getline(1) ~= "" then
          return
        end
        require('cmp').setup({})
        vim.api.nvim_create_autocmd('VimEnter', {
          callback = function()
            insert_snippet_template("{")
          end,
        })
      end,
      desc = 'Auto insert snippets',   })
  '';
}
