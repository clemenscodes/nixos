{lib, ...}: {config, ...}: let
  cfg = config.modules.performance;
in {
  options = {
    modules = {
      performance = {
        power = {
          enable = lib.mkEnableOption "Enable an efficient power management" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.power.enable) {
    services = {
      logind = {
        lidSwitch = "ignore";
        lidSwitchDocked = "ignore";
        powerKey = "ignore";
      };
    };
    powerManagement = {
      inherit (cfg.power) enable;
    };
  };
}
