{lib, ...}: {config, ...}: let
  cfg = config.modules.networking;
in {
  options = {
    modules = {
      networking = {
        mtr = {
          enable = lib.mkEnableOption "Enable mtr (mytraceroute)" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.mtr.enable) {
    programs = {
      mtr = {
        inherit (cfg.mtr) enable;
      };
    };
  };
}
