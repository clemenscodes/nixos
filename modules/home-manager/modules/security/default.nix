{inputs}: {
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./bitwarden
      ./ssh
      ./gpg
      (import ./sops {inherit inputs;})
    ];
    options = {
      modules = {
        security = {
          enable = mkEnableOption "Enable tools for security" // {default = cfg.enable;};
        };
      };
    };
  }
