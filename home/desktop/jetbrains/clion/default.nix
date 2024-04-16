{
  lib,
  config,
  nixpkgs,
  system,
  ...
}:
with lib; let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  cfg = config.jetbrains.clion;
in {
  options = {
    jetbrains = {
      clion = {
        enable = mkEnableOption "Enables CLion";
      };
    };
  };
  config = mkIf (config.jetbrains.enable && cfg.enable) {
    home = {
      packages = with pkgs; [
        jetbrains.clion
      ];
    };
  };
}
