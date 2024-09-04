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
      ./nix-prefetch-github
      ./nix-prefetch-git
      ./ripgrep
      ./unzip
    ];
    options = {
      modules = {
        utils = {
          enable = mkEnableOption "Enable useful utils" // {default = cfg.enable;};
        };
      };
    };
  }
