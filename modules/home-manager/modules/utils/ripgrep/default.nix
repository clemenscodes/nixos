{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.utils;
in {
  options = {
    modules = {
      utils = {
        ripgrep = {
          enable = mkEnableOption "Enable bat" // {default = cfg.enable;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.ripgrep.enable) {
    programs = {
      ripgrep = {
        enable = cfg.ripgrep.enable;
        arguments = [
          "--max-columns=150"
          "--max-columns-preview"
          "--hidden"
          "--glob=!.git/*"
          "--smart-case"
          "--colors=line:style:bold"
        ];
      };
    };
  };
}
