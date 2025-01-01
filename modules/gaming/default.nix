{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.gaming;
  wine = pkgs.wineWowPackages.unstableFull;
in {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    (import ./emulation {inherit inputs pkgs lib;})
    (import ./gamemode {inherit inputs pkgs lib;})
    (import ./gamescope {inherit inputs pkgs lib;})
    (import ./steam {inherit inputs pkgs lib;})
    (import ./umu {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      gaming = {
        enable = lib.mkEnableOption "Enable gaming" // {default = false;};
      };
    };
  };
  config = lib.mkIf (cfg.enable) {
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
