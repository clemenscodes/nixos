{inputs}: {
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./gnome-keyring
      ./gnupg
      ./hyprlock
      ./polkit
      ./rtkit
      (import ./sops {inherit inputs;})
      ./ssh
      ./sudo
      ./swaylock
      ./tpm
    ];
    options = {
      modules = {
        security = {
          enable = mkEnableOption "Enable common security settings" // {default = cfg.enable;};
        };
      };
    };
  }
