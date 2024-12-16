{inputs}: {
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      (import ./android {inherit inputs;})
      ./c
      ./corepack
      ./direnv
      ./gh
      ./git
      ./node
      ./pentesting
      ./postman
      ./reversing
    ];
    options = {
      modules = {
        development = {
          enable = mkEnableOption "Enable development tools" // {default = cfg.enable;};
        };
      };
    };
  }
