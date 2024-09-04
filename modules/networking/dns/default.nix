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
          dns = {
            enable = mkEnableOption "Enable additional DNS servers" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.dns.enable) {
      networking = {
        nameservers = [
          "1.1.1.1"
          "8.8.4.4"
        ];
      };
    };
  }
