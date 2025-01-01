{lib, ...}: {config, ...}: let
  cfg = config.modules.networking;
in {
  options = {
    modules = {
      networking = {
        firewall = {
          enable = lib.mkEnableOption "Enable firewall" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.firewall.enable) {
    networking = {
      nftables = {
        inherit (cfg.firewall) enable;
      };
      firewall = {
        inherit (cfg.firewall) enable;
      };
    };
  };
}
