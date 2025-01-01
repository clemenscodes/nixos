{inputs, ...}: {
  lib,
  config,
  ...
}: let
  cfg = config.modules.gaming;
in {
  imports = [
    ./pcsx2
    (import ./rpcs3 {inherit inputs;})
  ];
  options = {
    modules = {
      gaming = {
        emulation = {
          enable = lib.mkEnableOption "Enable emulation" // {default = cfg.enable;};
        };
      };
    };
  };
}
