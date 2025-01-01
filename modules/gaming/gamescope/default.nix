{lib, ...}: {config, ...}: let
  cfg = config.modules.gaming;
in {
  options = {
    modules = {
      gaming = {
        gamescope = {
          enable = lib.mkEnableOption "Enable gamescope" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.gamescope.enable) {
    programs = {
      gamescope = {
        inherit (cfg.gamescope) enable;
      };
    };
  };
}
