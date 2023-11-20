{ pkgs }:

pkgs.writeShellScriptBin "detectidle" ''
  ${pkgs.swayidle}/bin/swayidle -w \
    timeout 240 '${pkgs.libnotify}/bin/notify-send "Idle! locking soon..."' \
    timeout 300 'swaylock -f' \
    timeout 360 '${pkgs.hyprland}/bin/hyprctl dispatch dpms off' \
    timeout 420 '${pkgs.systemd}/bin/systemctl suspend' \
    resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' \
    before-sleep 'swaylock --fade-in 0.5 --grace 0.5 -f; sleep 1'
''
