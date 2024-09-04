{
  config,
  lib,
  ...
}: let
  cfg = config.modules.performance;
in
  with lib; {
    options = {
      modules = {
        performance = {
          tlp = {
            enable = mkEnableOption "Enable battery life optimizations" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.tlp.enable) {
      services = {
        tlp = {
          enable = cfg.tlp.enable;
        };
      };
    };
  }
