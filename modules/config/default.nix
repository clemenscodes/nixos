{
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./cachix
      ./nix
    ];
    options = {
      modules = {
        config = {
          enable = mkEnableOption "Enable common configurations" // {default = cfg.enable;};
        };
      };
    };
  }
