{inputs}: {
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.gaming;
  wine = pkgs.wineWowPackages.waylandFull;
in
  with lib; {
    imports = [
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      (import ./emulation {inherit inputs;})
      ./gamemode
      ./gamescope
      ./steam
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
          wine
          winetricks
          protontricks
          mangohud
          (lutris.override {
            extraPkgs = pkgs: [
              wine
              winetricks
              gamescope
            ];
          })
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
