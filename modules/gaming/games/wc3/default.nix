{
  lib,
  config,
  ...
}: let
  cfg = config.modules.gaming.games;
  inherit (config.modules.users) user;
in
  with lib; {
    options = {
      modules = {
        gaming = {
          games = {
            wc3 = {
              enable = mkEnableOption "Enable wc3" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.wc3.enable) {
      home-manager = {
        users = {
          ${user} = {
            home = {
              file = {
                "Games/warcraft-iii-reforged/dosdevices/c:/users/${user}/Documents/Warcraft III/CustomKeyBindings/CustomKeys.txt" = {
                  text = import ./keybinds.nix;
                };
                ".local/share/games/wc3/warcraft-iii-reforged-battlenet-w3champion.yaml" = {
                  text = import ./lutris.nix;
                };
              };
            };
          };
        };
      };
    };
  }
