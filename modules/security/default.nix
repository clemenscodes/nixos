{inputs, ...}: {
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in {
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
        enable = lib.mkEnableOption "Enable common security settings" // {default = cfg.enable;};
      };
    };
  };
}
