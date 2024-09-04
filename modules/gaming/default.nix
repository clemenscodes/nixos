{inputs}: {
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.gaming;
in
  with lib; {
    imports = [
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      ./emulation
      ./gamemode
      ./games
      ./gamescope
      ./steam
      ./wine
    ];
    options = {
      modules = {
        gaming = {
          enable = mkEnableOption "Enable gaming" // {default = false;};
        };
      };
    };
    config = mkIf (cfg.enable) {
      environment = {
        systemPackages = with pkgs; [
          wineWowPackages.waylandFull
          winetricks
          protontricks
          lutris
        ];
      };
      services = {
        pipewire = {
          lowLatency = {
            enable = cfg.enable;
            quantum = 64;
            rate = 48000;
          };
        };
      };
      nix = {
        settings = {
          substituters = ["https://nix-gaming.cachix.org"];
          trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
        };
      };
    };
  }
