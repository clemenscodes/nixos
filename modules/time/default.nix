{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    options = {
      modules = {
        time = {
          enable = mkEnableOption "Enable time settings" // {default = cfg.enable;};
          defaultTimeZone = mkOption {
            type = types.str;
            default = "Europe/Berlin";
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.time.enable) {
      time = {
        timeZone = cfg.time.defaultTimeZone;
      };
    };
  }
