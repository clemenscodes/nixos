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
  cfg = config.jetbrains.pycharm;
in {
  options = {
    jetbrains = {
      pycharm = {
        enable = mkEnableOption "Enables PyCharm";
      };
    };
  };
  config = mkIf (config.jetbrains.enable && cfg.enable) {
    home = {
      packages = with pkgs; [
        jetbrains.pycharm-community
      ];
    };
  };
}
