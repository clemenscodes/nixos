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
          power = {
            enable = mkEnableOption "Enable an efficient power management" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.power.enable) {
      services = {
        logind = {
          lidSwitch = "ignore";
          lidSwitchDocked = "ignore";
          powerKey = "ignore";
        };
      };
      powerManagement = {
        enable = cfg.power.enable;
      };
    };
  }
