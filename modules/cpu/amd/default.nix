{lib, ...}: {config, ...}: let
  cfg = config.modules.cpu;
in {
  options = {
    modules = {
      cpu = {
        amd = {
          enable = lib.mkEnableOption "Enable AMD CPU settings" // {default = cfg.enable;};
        };
      };
    };
  };
}
