{
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./bat
      ./fzf
      ./lpi
      ./lsusb
      ./nix-prefetch-github
      ./nix-prefetch-git
      ./ripgrep
      ./tldr
      ./unzip
      ./zip
    ];
    options = {
      modules = {
        utils = {
          enable = mkEnableOption "Enable useful utils" // {default = cfg.enable;};
        };
      };
    };
  }
