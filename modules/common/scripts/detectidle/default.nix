{ pkgs }:

pkgs.writeShellScriptBin "detectidle" ''
  ${pkgs.swayidle}/bin/swayidle -w \
    timeout 240 '${pkgs.libnotify}/bin/notify-send "Idle! locking soon..."' \
    timeout 300 '${pkgs.swaylock}/bin/swaylock -f || signout' \
    timeout 360 '${pkgs.hyprland}/bin/hyprctl dispatch dpms off' \
    resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' \
    before-sleep '${pkgs.swaylock}/bin/swaylock --fade-in 0 --grace 0 -f || signout; sleep 1' \
    lock '${pkgs.swaylock}/bin/swaylock --fade-in 0 --grace 0 -f || signout' 
''
