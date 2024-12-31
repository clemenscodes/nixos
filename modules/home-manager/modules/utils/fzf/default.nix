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
        fzf = {
          enable = lib.mkEnableOption "Enable fzf" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.fzf.enable) {
    programs = {
      fzf = {
        enable = cfg.fzf.enable;
      };
    };
  };
}
