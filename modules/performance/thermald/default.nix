{
  config,
  lib,
  ...
}: let
  cfg = config.modules.performance;
in
  with lib; {
    options = {
      modules = {
        performance = {
          thermald = {
            enable = mkEnableOption "Enable an efficient temperature management" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.thermald.enable) {
      services = {
        thermald = {
          enable = cfg.thermald.enable;
        };
      };
    };
  }
