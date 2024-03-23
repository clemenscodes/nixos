{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      steamtinkerlaunch
    ];
  };
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            gamescope
            gamemode
          ];
      };
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
  };
}
