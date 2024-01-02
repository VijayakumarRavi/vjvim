{
  description = "Vijay's Neovim (vjvim) Configuration";
  nixConfig = {
    extra-substituters = [
      "https://vjvim.cachix.org?priority=1"
      "https://nix-community.cachix.org?priority=2"
      "https://cache.nixos.org?priority=3"
    ];
    extra-trusted-public-keys = [
      "vjvim.cachix.org-1:AF3grdItpExuZ95D16gb7DN/9kYhf91OwZoNBCfHW98="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs"; };
    flake-utils.url = "github:numtide/flake-utils";
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, neovim, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlayFlakeInputs = prev: final: {
          neovim = neovim.packages.${system}.neovim;
        };

        overlayvjvim = prev: final: {
          vjvim = import ./packages/vjvim.nix { pkgs = final; };
        };

        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlayFlakeInputs overlayvjvim ];
        };

      in {
        packages = rec {
          vjvim = pkgs.vjvim;
          default = vjvim;
        };
        apps = rec {
          default = vjvim;
          vjvim = flake-utils.lib.mkApp {
            drv = self.packages.${system}.vjvim;
            name = "vjvim";
            exePath = "/bin/nvim";
          };
        };
      });
}
