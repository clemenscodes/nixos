{
  config,
  lib,
  ...
}: let
  cfg = config.modules.security;
  io = config.modules.io.enable;
in
  with lib; {
    options = {
      modules = {
        security = {
          rtkit = {
            enable = mkEnableOption "Enable realtime kit" // {default = cfg.enable && io;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.rtkit.enable && io) {
      security = {
        rtkit = {
          inherit (cfg.rtkit) enable;
        };
      };
    };
  }
