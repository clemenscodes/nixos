{ pkgs }: 

pkgs.writeShellScriptBin "waybar-swaync" ''
  sleep 0.1
  ${pkgs.swaynotificationcenter}/bin/swaync-client --inhibitor-add xdg-desktop-portal-hyprland
  ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw 
  ${pkgs.swaynotificationcenter}/bin/swaync-client --inhibitor-remove xdg-desktop-portal-hyprland
''

