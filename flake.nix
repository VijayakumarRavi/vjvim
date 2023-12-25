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
      overlayFlakeInputsDarwin = prev: final: {
        neovim = neovim.packages.aarch64-darwin.neovim;
      };
      overlayFlakeInputsLinux = prev: final: {
        neovim = neovim.packages.x86_64-linux.neovim;
      };

      overlayvjvim = prev: final: {
        vjvim = import ./packages/vjvim.nix {
          pkgs = final;
        };
      };

      pkgsdarwin = import nixpkgs {
        system = "aarch64-darwin";
        name = "vjvim";
        overlays = [ overlayFlakeInputsDarwin overlayvjvim ];
      };
      pkgslinux = import nixpkgs {
        system = "x86_64-linux";
        name = "vjvim";
        overlays = [ overlayFlakeInputsLinux overlayvjvim ];
      };

    in {
      packages.aarch64-darwin.default = pkgsdarwin.vjvim;
      apps.aarch64-darwin.default = {
        type = "app";
        name = "vjvim";
        program = "${pkgsdarwin.vjvim}/bin/nvim";
      };
      packages.x86_64-linux.default = pkgslinux.vjvim;
      apps.x86_64-linux.default = {
        type = "app";
        name = "vjvim";
        program = "${pkgslinux.vjvim}/bin/nvim";
      };
    };
}
