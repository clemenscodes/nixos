{pkgs, ...}: {config, ...}: let
  cfg = config.modules.terminal;
in {
  options = {
    modules = {
      terminal = {
        ghostty = {
          enable = pkgs.lib.mkEnableOption "Enable ghostty" // {default = cfg.enable;};
        };
      };
    };
  };
  config = pkgs.lib.mkIf (cfg.enable && cfg.ghostty.enable) {
    home = {
      packages = [pkgs.ghostty];
    };
  };
}
