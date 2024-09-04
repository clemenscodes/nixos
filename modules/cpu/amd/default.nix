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
          amd = {
            enable = mkEnableOption "Enable AMD CPU settings" // {default = cfg.enable;};
          };
        };
      };
    };
  }
