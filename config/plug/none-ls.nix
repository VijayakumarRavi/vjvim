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
        codespell.enable = true;
        actionlint.enable = true;
        golangci_lint.enable = true;
        yamllint = {
          enable = true;
          settings = {
            extra_args = [
              "-d"
              ''
                {
                extends: default,
                rules: {
                  line-length: {max: 160},
                  document-start: disable,
                  comments: {
                    min-spaces-from-content: 1,
                  },
                }
                }
              ''
            ];
          };
        };
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
        gofumpt.enable = true;
        golines.enable = true;
        goimports_reviser.enable = true;
        just.enable = true;
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
