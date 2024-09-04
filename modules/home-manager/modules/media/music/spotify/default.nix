{
  nixpkgs,
  lib,
  system,
  config,
  osConfig,
  ...
}:
with lib; let
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (getName pkg) ["spotify"];
    };
  };
  cfg = config.modules.media.music;
  isDesktop = osConfig.modules.display.gui != "headless";
in {
  options = {
    modules = {
      media = {
        music = {
          spotify = {
            enable = mkEnableOption "Enable spotify" // {default = cfg.enable && isDesktop;};
          };
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.spotify.enable && isDesktop) {
    home = {
      packages = [pkgs.spotify];
    };
  };
}
