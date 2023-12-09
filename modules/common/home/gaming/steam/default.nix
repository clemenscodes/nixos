{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.steamCompat];
  environment = {
    systemPackages = with pkgs; [
      steamtinkerlaunch
      python3
      er-patcher
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
            python3
            er-patcher
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
