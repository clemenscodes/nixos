{
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    options = {
      modules = {
        display = {
          qt = {
            enable = mkEnableOption "Enable qt" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.qt.enable) {
      qt = {
        inherit (cfg.qt) enable;
      };
    };
  }
