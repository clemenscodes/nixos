{lib, ...}: {config, ...}: let
  cfg = config.modules.networking;
in {
  options = {
    modules = {
      networking = {
        stevenblack = {
          enable = lib.mkEnableOption "Enable stevenblack" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.stevenblack.enable) {
    networking = {
      stevenblack = {
        inherit (cfg.stevenblack) enable;
        block = ["fakenews" "gambling" "porn"];
      };
    };
  };
}
