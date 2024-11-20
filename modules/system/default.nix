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
        system = {
          enable = mkEnableOption "Enable system settings" // {default = cfg.enable;};
          defaultVersion = mkOption {
            type = types.str;
            default = "25.05";
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.system.enable) {
      system = {
        stateVersion = cfg.system.defaultVersion;
      };
    };
  }
