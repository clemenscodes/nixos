{
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./btop
      ./ncdu
    ];
    options = {
      modules = {
        monitoring = {
          enable = mkEnableOption "Enable tools for monitoring the system" // {default = cfg.enable;};
        };
      };
    };
  }
