{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.networking;
in
  with lib; {
    options = {
      modules = {
        networking = {
          wireshark = {
            enable = mkEnableOption "Enable wireshark" // {default = osConfig.modules.networking.wireshark.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.wireshark.enable) {
      home = {
        packages = with pkgs; [wireshark];
      };
    };
  }
