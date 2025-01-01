{lib, ...}: {config, ...}: let
  cfg = config.modules.security;
  io = config.modules.io.enable;
in {
  options = {
    modules = {
      security = {
        rtkit = {
          enable = lib.mkEnableOption "Enable realtime kit" // {default = cfg.enable && io;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.rtkit.enable && io) {
    security = {
      rtkit = {
        inherit (cfg.rtkit) enable;
      };
    };
  };
}
