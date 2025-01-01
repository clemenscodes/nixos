{lib, ...}: {config, ...}: let
  cfg = config.modules.boot;
in {
  options = {
    modules = {
      boot = {
        fuse = {
          enable = lib.mkEnableOption "Enable fuse" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.fuse.enable) {
    programs = {
      fuse = {
        userAllowOther = cfg.fuse.enable;
      };
    };
  };
}
