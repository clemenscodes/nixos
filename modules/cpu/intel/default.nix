{lib, ...}: {config, ...}: let
  cfg = config.modules.cpu;
in {
  options = {
    modules = {
      cpu = {
        intel = {
          enable = lib.mkEnableOption "Enable Intel CPU settings" // {default = cfg.enable;};
        };
      };
    };
  };
}
