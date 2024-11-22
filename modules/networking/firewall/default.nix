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
        nftables = {
          inherit (cfg.firewall) enable;
        };
        firewall = {
          inherit (cfg.firewall) enable;
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
              from = 6112;
              to = 6119;
            }
          ];
          allowedUDPPortRanges = [
            {
              from = 6112;
              to = 6119;
            }
          ];
        };
      };
    };
  }
