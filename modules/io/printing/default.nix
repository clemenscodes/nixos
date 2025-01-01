{lib, ...}: {config, ...}: let
  cfg = config.modules.io;
in {
  options = {
    modules = {
      io = {
        printing = {
          enable = lib.mkEnableOption "Enable printing services" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.printing.enable) {
    services = {
      printing = {
        enable = cfg.printing.enable;
      };
    };
  };
}
