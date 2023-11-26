{ pkgs, ... }: {
  programs = {
    steam = {
      enable = true;
      package = (pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          gamescope
          mangohud
        ];
      });
      remotePlay = {
        openFirewall = true; # Open ports in the firewall for Steam Remote Play
      };
      dedicatedServer = {
        openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      };
    };
  };
}
