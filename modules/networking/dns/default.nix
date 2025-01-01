{lib, ...}: {config, ...}: let
  cfg = config.modules.networking;
in {
  options = {
    modules = {
      networking = {
        dns = {
          enable = lib.mkEnableOption "Enable additional DNS servers" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.dns.enable) {
    networking = {
      nameservers = [
        "1.1.1.1"
        "8.8.4.4"
      ];
    };
  };
}
