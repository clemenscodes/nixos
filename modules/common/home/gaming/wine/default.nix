{
  inputs,
  pkgs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      wineWowPackages.waylandFull
      winetricks
    ];
    variables = {
      WINE_LARGE_ADDRESS_AWARE = "1";
    };
  };
}
