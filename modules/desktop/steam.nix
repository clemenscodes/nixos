{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];
  environment = {
    systemPackages = with pkgs; [
      steamtinkerlaunch
      wineWowPackages.waylandFull
      winetricks
      protontricks
      lutris
    ];
    variables = {
      WINE_LARGE_ADDRESS_AWARE = "1";
    };
  };
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam;
      gamescopeSession = {
        enable = true;
      };
      remotePlay = {
        openFirewall = true;
      };
      dedicatedServer = {
        openFirewall = true;
      };
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    gamescope = {
      enable = true;
    };
    gamemode = {
      enable = true;
    };
  };
  services = {
    pipewire = {
      lowLatency = {
        enable = true;
        quantum = 64;
        rate = 48000;
      };
    };
  };
}
