{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./multiplexers
      ./nom
      ./nvd
      ./starship
      ./zoxide
      ./zsh
    ];
    options = {
      modules = {
        shell = {
          enable = mkEnableOption "Enable home-manager shell modules" // {default = cfg.enable;};
          defaultShell = mkOption {
            type = types.enum ["zsh" "bash"];
            default = "zsh";
          };
        };
      };
    };
  }
