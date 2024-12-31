{
  config,
  lib,
  ...
}: let
  cfg = config.modules.monitoring;
in {
  options = {
    modules = {
      monitoring = {
        btop = {
          enable = lib.mkEnableOption "Enable btop monitoring" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.btop.enable) {
    programs = {
      btop = {
        enable = cfg.btop.enable;
        settings = {
          vim_keys = true;
        };
      };
    };
  };
}
