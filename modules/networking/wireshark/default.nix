{lib, ...}: {config, ...}: let
  cfg = config.modules.networking;
  inherit (config.modules.users) user;
in {
  options = {
    modules = {
      networking = {
        wireshark = {
          enable = lib.mkEnableOption "Enable wireshark" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.wireshark.enable) {
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
