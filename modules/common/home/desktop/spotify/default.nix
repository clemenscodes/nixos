{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      spotify 
    # (writeShellApplication {
    #   name = "discord";
    #   text = "${pkgs.discord}/bin/discord --use-gl=desktop";
    # })
    # (makeDesktopItem {
    #   name = "discord";
    #   exec = "discord";
    #   desktopName = "Discord";
    #   icon = "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle/scalable/apps/discord.svg";
    # })
    ];
  };
}
