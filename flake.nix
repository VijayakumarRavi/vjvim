{
  description = "Vijay's Neovim (vjvim) Configuration";
  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://vjvim.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "vjvim.cachix.org-1:AF3grdItpExuZ95D16gb7DN/9kYhf91OwZoNBCfHW98="
    ];
  };
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, neovim }:
    let
      overlayFlakeInputs = prev: final: {
        neovim = neovim.packages.aarch64-darwin.neovim;
      };

      overlayvjvim = prev: final: {
        vjvim = import ./packages/vjvim.nix {
          pkgs = final;
        };
      };

      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        name = "vjvim";
        overlays = [ overlayFlakeInputs overlayvjvim ];
      };

    in {
      packages.aarch64-darwin.default = pkgs.vjvim;
      packages.aarch64-darwin.vjvim = pkgs.vjvim;
      apps.aarch64-darwin.default = {
        type = "app";
        name = "vjvim";
        program = "${pkgs.vjvim}/bin/nvim";
      };
      apps.aarch64-darwin.vjvim = {
        type = "app";
        name = "vjvim";
        program = "${pkgs.vjvim}/bin/nvim";
      };
    };
}
