{inputs}: {
  pkgs,
  lib,
  config,
  system,
  ...
}:
with lib;
with pkgs; let
  cfg = config.modules.gaming.emulation;
in {
  options = {
    modules = {
      gaming = {
        emulation = {
          rpcs3 = {
            enable = mkEnableOption "Enable rpcs3 emulation (PlayStation 3)" // {default = cfg.enable;};
          };
        };
      };
    };
  };
}
