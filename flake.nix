{
  description = "Vijay's Kickstart Neovim (vjvim-kickstart) Configuration";

  nixConfig = {
    extra-substituters = [
      "https://atticfly.fly.dev/system?priority=1"
      "https://nix-community.cachix.org?priority=2"
      "https://cache.nixos.org?priority=3"
    ];
    extra-trusted-public-keys = [
      "system:4DUyL9UsLftxdxGfmAyxfU5TnQc+8vD/uRBryYSonss="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugin-hlchunk-nvim = {
      url = "github:shellRaining/hlchunk.nvim";
      flake = false;
    };

    plugin-snipe-nvim = {
      url = "github:leath-dub/snipe.nvim";
      flake = false;
    };

    plugin-visual-surround-nvim = {
      url = "github:NStefan002/visual-surround.nvim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    pre-commit-hooks,
    ...
  } @ inputs: let
    systems = ["aarch64-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin"];
    eachSystem = f:
      nixpkgs.lib.genAttrs systems (system:
        f (import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }));
  in {
    packages = eachSystem (pkgs: let
      runtimeDeps = with pkgs; [
        ripgrep
        fd
        lua-language-server
        gopls
        nixd
        alejandra
        ansible-language-server
        yaml-language-server
        dockerfile-language-server
        docker-compose-language-service
        typos-lsp
        gcc
        git
        gnumake
      ];

      baseWrappedNeovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
        luaRcContent = ''
          vim.opt.runtimepath:prepend("${./.}")
          require("init")
        '';
        plugins = with pkgs.vimPlugins; [
          alpha-nvim
          auto-save-nvim
          rose-pine
          tokyonight-nvim
          nvim-cmp
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          cmp_luasnip
          cmp-cmdline
          cmp-emoji
          lspkind-nvim
          conform-nvim
          gitsigns-nvim
          git-worktree-nvim
          lazygit-nvim
          nvim-lspconfig
          lspsaga-nvim
          lualine-nvim
          luasnip
          friendly-snippets
          none-ls-nvim
          oil-nvim
          telescope-nvim
          plenary-nvim
          telescope-fzf-native-nvim
          telescope-ui-select-nvim
          nvim-web-devicons
          project-nvim
          telescope-frecency-nvim
          nvim-treesitter.withAllGrammars
          nvim-tree-lua
          nvim-treesitter-textobjects
          nvim-treesitter-context
          nvim-ts-autotag
          leap-nvim
          vim-wakatime
          which-key-nvim
          comment-nvim
          nvim-ufo
          promise-async
          nvim-autopairs
          vim-illuminate
          harpoon
          toggleterm-nvim
          zen-mode-nvim
          (pkgs.vimUtils.buildVimPlugin {
            name = "hlchunk";
            src = inputs.plugin-hlchunk-nvim;
          })
          (pkgs.vimUtils.buildVimPlugin {
            name = "visual-surround-nvim";
            src = inputs.plugin-visual-surround-nvim;
          })
          (pkgs.vimUtils.buildVimPlugin {
            name = "snipe-nvim";
            src = inputs.plugin-snipe-nvim;
          })
        ];
        wrapperArgs = [
          "--set"
          "NVIM_APPNAME"
          "vjvim"
          "--prefix"
          "PATH"
          ":"
          "${pkgs.lib.makeBinPath runtimeDeps}"
        ];
      };

      wrappedNeovim = pkgs.symlinkJoin {
        name = "vjvim";
        paths = [baseWrappedNeovim];
        postBuild = ''
          ln -s $out/bin/nvim $out/bin/vjvim
        '';
      };
    in {
      default = wrappedNeovim;
      vjvim = wrappedNeovim;
    });

    formatter = eachSystem (pkgs: pkgs.alejandra);

    checks = eachSystem (pkgs: {
      pre-commit-check = pre-commit-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
          actionlint.enable = true;
          shellcheck.enable = true;
          flake-checker.enable = true;
          check-symlinks.enable = true;
          end-of-file-fixer.enable = true;
          detect-private-keys.enable = true;
          trim-trailing-whitespace.enable = true;
          trim-trailing-whitespace.stages = ["pre-commit"];
          deadnix = {
            enable = true;
            settings = {
              edit = true;
              noLambdaArg = true;
            };
          };
          statix = {
            enable = true;
            files = "\\.nix$";
            name = "statix-fix";
            entry = "${pkgs.statix}/bin/statix fix";
          };
        };
      };
    });

    devShells = eachSystem (pkgs: {
      default = pkgs.mkShell {
        inherit (self.checks.${pkgs.stdenv.hostPlatform.system}.pre-commit-check) shellHook;
        buildInputs = [self.packages.${pkgs.stdenv.hostPlatform.system}.vjvim] ++ self.checks.${pkgs.stdenv.hostPlatform.system}.pre-commit-check.enabledPackages;
      };
    });
  };
}
