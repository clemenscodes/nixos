{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.explorer;
in
  with lib; {
    options = {
      modules = {
        explorer = {
          dolphin = {
            enable = mkEnableOption "Enable dolphin file browser" // {default = cfg.defaultExplorer == "dolphin";};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.dolphin.enable) {
      home = {
        packages = with pkgs; [
          dolphin
        ];
      };
    };
  }
