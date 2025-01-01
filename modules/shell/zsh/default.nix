{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.shell;
in {
  options = {
    modules = {
      shell = {
        zsh = {
          enable = lib.mkEnableOption "Enable zsh" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.zsh.enable) {
    programs = {
      zsh = {
        inherit (cfg.zsh) enable;
      };
    };
    environment = {
      shells = [pkgs.zsh];
    };
  };
}
