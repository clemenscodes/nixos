{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.steamCompat];
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
      extraCompatPackages = [
        inputs.nix-gaming.packages.${pkgs.system}.proton-ge
      ];
    };
  };
}
