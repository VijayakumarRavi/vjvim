{
  config,
  lib,
  ...
}: let
  # Read all files in the current directory and the 'plug' directory
  files = builtins.readDir ./.;
  plugFiles = builtins.readDir ./plug;

  # Filter out default.nix and non-.nix files from both directories
  nixFiles =
    builtins.filter
    (name: name != "default.nix" && builtins.match ".*\\.nix" name != null)
    (builtins.attrNames files ++ builtins.attrNames plugFiles);

  # Create a list of import statements for both directories
  imports = map (name:
    if builtins.elem name (builtins.attrNames files)
    then ./. + "/${name}"
    else ./plug + "/${name}")
  nixFiles;
in {
  # Import all configuration modules automatically
  inherit imports;

  # Theme options
  options = {
    theme = lib.mkOption {
      default = lib.mkDefault "tokyonight";
      type = lib.types.enum [
        "paradise"
        "decay"
        "edge-dark"
        "mountain"
        "tokyonight"
        "everforest"
        "everblush"
        "jellybeans"
        "aquarium"
        "gruvbox"
      ];
    };
  };

  # Configuration
  config = {
    theme = "paradise";
    extraConfigLua = ''
      _G.theme = "${config.theme}"
    '';
  };
}
