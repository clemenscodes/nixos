{inputs, ...}: {
  config,
  lib,
  system,
  ...
}: let
  cfg = config.modules.terminal;
in {
  options = {
    modules = {
      terminal = {
        ghostty = {
          enable = lib.mkEnableOption "Enable ghostty" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.ghostty.enable) {
    home = {
      packages = [inputs.ghostty.packages.${system}.default];
    };
  };
}
