{lib, ...}: {config, ...}: let
  cfg = config.modules.display;
in {
  options = {
    modules = {
      display = {
        gtk = {
          enable = lib.mkEnableOption "Enable GTK" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.gtk.enable) {
    gtk = {
      iconCache = {
        enable = cfg.gtk.enable;
      };
    };
  };
}
