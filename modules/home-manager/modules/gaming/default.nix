{inputs}: {
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules;
in {
  imports = [
    inputs.ps3-nix.homeManagerModules.default
  ];
  options = {
    modules = {
      gaming = {
        enable = mkEnableOption "Enable home-manager gaming" // {default = false;};
      };
    };
  };
  config = mkIf (cfg.gaming.enable) {
    playstation3 = {
      inherit (cfg.gaming) enable;
    };
  };
}
