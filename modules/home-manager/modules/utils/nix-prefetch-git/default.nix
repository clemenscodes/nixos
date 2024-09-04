{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.utils;
in {
  options = {
    modules = {
      utils = {
        nix-prefetch-git = {
          enable = mkEnableOption "Enable nix-prefetch-git" // {default = cfg.enable;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.nix-prefetch-git.enable) {
    home = {
      packages = with pkgs; [nix-prefetch-git];
    };
  };
}
