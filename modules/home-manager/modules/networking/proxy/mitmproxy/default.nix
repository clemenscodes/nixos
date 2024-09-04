{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.networking.proxy;
in
  with lib; {
    options = {
      modules = {
        networking = {
          proxy = {
            mitmproxy = {
              enable = mkEnableOption "Enable mitmproxy" // {default = false;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.mitmproxy.enable) {
      home = {
        packages = with pkgs; [
          mitmproxy
        ];
      };
    };
  }
