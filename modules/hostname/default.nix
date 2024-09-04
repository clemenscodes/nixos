{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    options = {
      modules = {
        hostname = {
          enable = mkEnableOption "Enable hostname" // {default = cfg.enable;};
          defaultHostname = mkOption {
            type = types.str;
            default = "cymenix";
          };
        };
      };
    };
  }
