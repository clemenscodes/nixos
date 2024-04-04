{lib, ...}: {
  options = {
    desktop = {
      enable = lib.mkEnableOption "Enable desktop support";
    };
  };
  imports = [
    ./bitwarden
    ./blueman
    ./cursor
    ./corectrl
    ./discord
    ./dconf
    ./firefox
    ./gtk
    ./hyprland
    ./hyprpicker
    ./hyprshade
    ./libreoffice
    ./lact
    ./nm
    ./qt
    ./rofi
    ./vhs
    ./screenshots
    ./spotify
    ./transgui
    ./obs
    ./swayidle
    ./swayimg
    ./swaylock
    ./swaync
    ./udiskie
    ./waybar
    ./xwaylandvideobridge
    ./ydotool
    ./zathura
    ./jetbrains
    ./vscode
    ./ledger-live-desktop
  ];
}
