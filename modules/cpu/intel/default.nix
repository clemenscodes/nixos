{
  config,
  lib,
  ...
}: let
  cfg = config.modules.cpu;
in
  with lib; {
    options = {
      modules = {
        cpu = {
          intel = {
            enable = mkEnableOption "Enable Intel CPU settings" // {default = cfg.enable;};
          };
        };
      };
    };
  }
