{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.config;
in {
  options = {
    modules = {
      config = {
        cachix = {
          enable = lib.mkEnableOption "Enable common cachix options" // {default = cfg.enable;};
          token = lib.mkOption {
            type = lib.types.path;
            default = null;
          };
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.cachix.enable) {
    environment = {
      systemPackages = with pkgs; [cachix];
    };
  };
}
