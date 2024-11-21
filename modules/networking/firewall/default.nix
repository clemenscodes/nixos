{
  lib,
  config,
  ...
}: let
  cfg = config.modules.networking;
in
  with lib; {
    options = {
      modules = {
        networking = {
          firewall = {
            enable = mkEnableOption "Enable firewall" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.firewall.enable) {
      networking = {
        firewall = {
          enable = cfg.firewall.enable;
          allowedTCPPorts = [
            80
            443
            3000
            3552
            3560
            3572
            4200
            5000
            8000
            8080
          ];
          allowedTCPPortRanges = [
            {
              from = 30000;
              to = 60000;
            }
          ];
          allowedUDPPortRanges = [
            {
              from = 30000;
              to = 60000;
            }
          ];
        };
      };
    };
  }
