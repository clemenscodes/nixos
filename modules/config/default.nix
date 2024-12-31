{
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in {
  imports = [
    ./cachix
    ./nix
  ];
  options = {
    modules = {
      config = {
        enable = lib.mkEnableOption "Enable common configurations" // {default = cfg.enable;};
      };
    };
  };
}
