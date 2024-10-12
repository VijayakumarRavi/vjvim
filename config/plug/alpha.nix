{
  plugins.alpha = let
    nixFlake = [
      "                                                                       "
      "                                                                       "
      "                                                                       "
      "                                                                       "
      "                                                                     "
      "       ████ ██████           █████      ██                     "
      "      ███████████             █████                             "
      "      █████████ ███████████████████ ███   ███████████   "
      "     █████████  ███    █████████████ █████ ██████████████   "
      "    █████████ ██████████ █████████ █████ █████ ████ █████   "
      "  ███████████ ███    ███ █████████ █████ █████ ████ █████  "
      " ██████  █████████████████████ ████ █████ █████ ████ ██████ "
      "                                                                       "
      "                                                                       "
      "                                                                       "
    ];
  in {
    enable = true;
    layout = [
      {
        type = "padding";
        val = 4;
      }
      {
        opts = {
          hl = "AlphaHeader";
          position = "center";
        };
        type = "text";
        val = nixFlake;
      }
      {
        type = "padding";
        val = 2;
      }
      {
        type = "group";
        val = let
          mkButton = shortcut: cmd: val: hl: {
            type = "button";
            inherit val;
            on_press.__raw = "function() vim.cmd[[${cmd}]] end";
            opts = {
              inherit hl shortcut;
              keymap = [
                "n"
                shortcut
                "<CMD>${cmd}<CR>"
                {}
              ];
              position = "center";
              cursor = 40;
              width = 40;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          };
        in [
          (mkButton "n" "ene" "  New file" "Operator")

          (mkButton "f" "lua if vim.fn.argc() == 0 then require('telescope').extensions['frecency'].frecency({prompt_prefix='  '}) end" "  Browse File" "Operator")

          (mkButton "p" "lua require('telescope').extensions.projects.projects{}" "  Projects" "Operator")

          (mkButton "g" "LazyGit" "  Open LazyGit" "Constant")

          (mkButton "q" "qa" "  Quit Neovim" "String")
        ];
      }
      {
        type = "padding";
        val = 2;
      }
      {
        opts = {
          hl = "GruvboxBlue";
          position = "center";
        };
        type = "text";
        val = "https://github.com/vijayakumarravi/vjvim";
      }
    ];
  };
}
