{ inputs, pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      inputs.nix-gaming.packages.${pkgs.system}.wine-ge
      wineWowPackages.waylandFull
      wineWowPackages.staging
      winetricks
    ];
  };
}
