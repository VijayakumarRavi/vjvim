{
  plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    settings = {
      updateInInsert = false;
    };
    sources = {
      code_actions = {
        gitsigns.enable = true;
        statix.enable = true;
      };
      diagnostics = {
        statix.enable = true;
        yamllint.enable = true;
        codespell.enable = true;
      };
      formatting = {
        alejandra.enable = true;
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
          settings = ''
            {
              extra_args = { "--no-semi", "--single-quote" },
            }
          '';
        };
        stylua.enable = true;
        yamlfmt.enable = true;
      };
    };
  };
  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>cf";
      action = "<cmd>lua vim.lsp.buf.format()<cr>";
      options = {
        silent = true;
        desc = "Format";
      };
    }
  ];
}
