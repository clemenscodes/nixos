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
        nix-prefetch-github = {
          enable = mkEnableOption "Enable nix-prefetch-github" // {default = cfg.enable;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.nix-prefetch-github.enable) {
    home = {
      packages = with pkgs; [nix-prefetch-github];
    };
  };
}
