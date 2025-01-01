{lib, ...}: {config, ...}: let
  cfg = config.modules.performance;
in {
  options = {
    modules = {
      performance = {
        thermald = {
          enable = lib.mkEnableOption "Enable an efficient temperature management" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.thermald.enable) {
    services = {
      thermald = {
        inherit (cfg.thermald) enable;
      };
    };
  };
}
