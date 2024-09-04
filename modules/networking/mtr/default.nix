{
  config,
  lib,
  ...
}: let
  cfg = config.modules.networking;
in
  with lib; {
    options = {
      modules = {
        networking = {
          mtr = {
            enable = mkEnableOption "Enable mtr (mytraceroute)" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.mtr.enable) {
      programs = {
        mtr = {
          enable = cfg.mtr.enable;
        };
      };
    };
  }
