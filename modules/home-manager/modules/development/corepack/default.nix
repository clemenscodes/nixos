{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.development;
in
  with lib; {
    options = {
      modules = {
        development = {
          corepack = {
            enable = mkEnableOption "Enable nodejs corepack (npm, yarn, pnpm)" // {default = cfg.enable && cfg.node.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.node.enable && cfg.corepack.enable) {
      home = {
        packages = with pkgs; [corepack];
      };
    };
  }
