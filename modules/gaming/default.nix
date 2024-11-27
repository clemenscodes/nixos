{inputs, ...}: {
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.gaming;
  wine = pkgs.wineWowPackages.unstableFull;
in
  with lib; {
    imports = [
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      (import ./emulation {inherit inputs;})
      ./gamemode
      ./gamescope
      ./steam
      (import ./umu {inherit inputs;})
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
        systemPackages = [
          wine
          pkgs.winetricks
          pkgs.protontricks
          pkgs.mangohud
          (pkgs.lutris.override {
            extraPkgs = pkgs: [
              wine
              pkgs.winetricks
              pkgs.gamescope
              pkgs.vulkan-tools
            ];
          })
        ];
      };
      services = {
        pipewire = {
          lowLatency = {
            inherit (cfg) enable;
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
