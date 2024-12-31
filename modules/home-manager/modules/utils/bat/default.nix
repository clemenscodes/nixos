{
  lib,
  config,
  ...
}: let
  cfg = config.modules.utils;
in {
  options = {
    modules = {
      utils = {
        bat = {
          enable = lib.mkEnableOption "Enable bat" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.bat.enable) {
    programs = {
      bat = {
        enable = cfg.bat.enable;
      };
    };
  };
}
