{lib, ...}: {config, ...}: let
  cfg = config.modules.display;
in {
  options = {
    modules = {
      display = {
        qt = {
          enable = lib.mkEnableOption "Enable qt" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.qt.enable) {
    qt = {
      inherit (cfg.qt) enable;
    };
  };
}
