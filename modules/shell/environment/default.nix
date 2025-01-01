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
        environment = {
          enable = lib.mkEnableOption "Enable basic environment settings" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.environment.enable) {
    environment = {
      localBinInPath = true;
      homeBinInPath = true;
      systemPackages = [pkgs.neovim];
    };
  };
}
