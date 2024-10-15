{inputs}: {
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./c
      (import ./cardano {inherit inputs;})
      ./corepack
      ./direnv
      ./gh
      ./git
      ./lazygit
      ./gitui
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
