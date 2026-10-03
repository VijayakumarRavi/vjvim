{pkgs, ...}: {
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      notify_on_error = true;

      formatters_by_ft = {
        lua = ["stylua"];
        nix = ["alejandra"];
        markdown = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "prettier";
          stop_after_first = true;
        };
        yaml = ["yamlfmt"];
      };
    };
  };

  extraPackages = with pkgs; [
    prettierd
    yamlfmt
    stylua
    alejandra
  ];
}
