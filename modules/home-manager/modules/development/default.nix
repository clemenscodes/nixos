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
      (import ./cardano {inherit inputs;})
      ./corepack
      ./direnv
      ./gh
      ./git
      ./node
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
