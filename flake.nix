{
  description = "Vijay's Neovim (vjvim) Configuration";
  
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
