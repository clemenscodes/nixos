{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules;
in {
  imports = [
    (import ./gnome-keyring {inherit inputs pkgs lib;})
    (import ./gnupg {inherit inputs pkgs lib;})
    (import ./hyprlock {inherit inputs pkgs lib;})
    (import ./polkit {inherit inputs pkgs lib;})
    (import ./rtkit {inherit inputs pkgs lib;})
    (import ./sops {inherit inputs pkgs lib;})
    (import ./ssh {inherit inputs pkgs lib;})
    (import ./sudo {inherit inputs pkgs lib;})
    (import ./swaylock {inherit inputs pkgs lib;})
    (import ./tpm {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      security = {
        enable = lib.mkEnableOption "Enable common security settings" // {default = cfg.enable;};
      };
    };
  };
}
