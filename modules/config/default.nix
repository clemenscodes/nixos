{
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
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
