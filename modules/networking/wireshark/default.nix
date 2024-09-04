{
  config,
  lib,
  ...
}: let
  cfg = config.modules.networking;
  inherit (config.modules.users) user;
in
  with lib; {
    options = {
      modules = {
        networking = {
          wireshark = {
            enable = mkEnableOption "Enable wireshark" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.wireshark.enable) {
      programs = {
        wireshark = {
          inherit (cfg.wireshark) enable;
        };
      };
      users = {
        users = {
          ${user} = {
            extraGroups = ["wireshark"];
          };
        };
      };
    };
  }
