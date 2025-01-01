{lib, ...}: {config, ...}: let
  cfg = config.modules.performance;
in {
  options = {
    modules = {
      performance = {
        tlp = {
          enable = lib.mkEnableOption "Enable battery life optimizations" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.tlp.enable) {
    services = {
      tlp = {
        inherit (cfg.tlp) enable;
      };
    };
  };
}
