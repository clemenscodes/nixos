{
  config,
  lib,
  ...
}: let
  cfg = config.modules.io;
in
  with lib; {
    options = {
      modules = {
        io = {
          printing = {
            enable = mkEnableOption "Enable printing services" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.printing.enable) {
      services = {
        printing = {
          enable = cfg.printing.enable;
        };
      };
    };
  }
