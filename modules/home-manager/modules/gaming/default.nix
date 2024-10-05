{inputs}: {
  config,
  lib,
  ...
}:
with lib; {
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
}
