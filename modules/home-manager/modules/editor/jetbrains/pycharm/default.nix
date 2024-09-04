{
  lib,
  config,
  nixpkgs,
  system,
  ...
}:
with lib; let
  cfg = config.modules.editor.jetbrains;
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  options = {
    modules = {
      editor = {
        jetbrains = {
          pycharm = {
            enable = mkEnableOption "Enable PyCharm" // {default = cfg.enable;};
          };
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.pycharm.enable) {
    home = {
      packages = with pkgs; [
        jetbrains.pycharm-community
      ];
    };
  };
}
