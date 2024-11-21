{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.boot;
in {
  options = {
    modules = {
      boot = {
        fuse = {
          enable = mkEnableOption "Enable fuse" // {default = false;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.fuse.enable) {
    programs = {
      fuse = {
        userAllowOther = cfg.fuse.enable;
      };
    };
  };
}
