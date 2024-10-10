{
  description = "Vijay's Neovim (vjvim) Configuration";
  nixConfig = {
    extra-substituters = [
      "https://vijay.cachix.org?priority=1"
      "https://nix-community.cachix.org?priority=2"
      "https://cache.nixos.org?priority=3"
    ];
    extra-trusted-public-keys = [
      "vijay.cachix.org-1:6Re6EF3Q58sxaIobAWP1QTwMUCSA0nYMrSJGUedL3Zk="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    Plugin-hlchunk-nvim = {
      url = "github:shellRaining/hlchunk.nvim";
      flake = false;
    };

    Plugin-snipe-nvim = {
      url = "github:leath-dub/snipe.nvim";
      flake = false;
    };

    Plugin-visual-surround-nvim = {
      url = "github:NStefan002/visual-surround.nvim";
      flake = false;
    };
  };

  outputs = {
    nixvim,
    flake-parts,
    pre-commit-hooks,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = {
        system,
        pkgs,
        self',
        lib,
        ...
      }: let
        nixvim' = nixvim.legacyPackages.${system};
        nvim = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          module = ./config;
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      in {
        packages = {
          default = nvim;
          vjvim = pkgs.writeShellScriptBin "vjvim" ''exec ${nvim}/bin/nvim "$@"'';
        };

        formatter = pkgs.alejandra;

        devShells = {
          default = with pkgs;
            mkShell {
              inherit (self'.checks.pre-commit-check) shellHook;
              buildInputs = [self'.packages.vjvim] ++ self'.checks.pre-commit-check.enabledPackages;
            };
        };

        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
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
                entry = "statix fix";
              };
              git-pull = {
                enable = true;
                name = "git-pull-remort";
                always_run = true;
                pass_filenames = false;
                stages = ["post-commit"];
                entry = "git pull --rebase --quiet --autostash";
              };
            };
          };
        };
      };
    };
}
