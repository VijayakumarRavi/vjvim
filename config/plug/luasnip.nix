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

    -- Basic Nix expression
    ls.add_snippets("nix", {
      s("nixbase", {
        t("{...}: {"),
        t({"", "  "}), i(1, ""),  -- Placeholder for adding key-value pairs
        t({"", "}"}),
      }),
    })

    -- Nix derivation snippet
    ls.add_snippets("nix", {
      s("mkdrv", {
        t("stdenv.mkDerivation rec {"),
        t({"", "  pname = \""}), i(1, ""), t("\";"),
        t({"", "  version = \""}), i(2, ""), t("\";"),
        t({"", "", "  src = fetchurl {"}),
        t({"", "    url = \""}), i(3, ""), t("\";"),
        t({"", "    sha256 = \""}), i(4, ""), t("\";"),
        t({"  };", "", "  buildInputs = [ "}),
        i(5, ""), t(" ];"),
        t({"", "};"}),
      }),
    })

    -- Shell.nix setup
    ls.add_snippets("nix", {
      s("shell", {
        t("{ pkgs ? import <nixpkgs> {} }:"),
        t({"", "", "pkgs.mkShell {"}),
        t({"  buildInputs = [ "}),
        i(1, ""), t(" ];"),
        t({"", "};"}),
      }),
    })

    -- Importing nixpkgs snippet
    ls.add_snippets("nix", {
      s("importpkgs", {
        t("let"),
        t({"", "  pkgs = import <nixpkgs> {} ;"}),
        t({"", "in"}),
        t({"", "{", "  "}), i(1, "# Your expression here"),
        t({"", "}"}),
      }),
    })

    -- NixOS Module Declaration
    ls.add_snippets("nix", {
      s("nixosmod", {
        t("{ config, lib, pkgs, ... }:"),
        t({"", "{", "  options = {};"}),
        t({"", "  config = {};"}),
        t({"", "}"}),
      }),
    })

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
            insert_snippet_template("nixbase")
          end,
        })
      end,
      desc = 'Auto insert snippets',   })
  '';
}
