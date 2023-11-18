{ pkgs }:

pkgs.writeShellScriptBin "idle" ''
  ${pkgs.swayidle}/bin/swayidle -w \
    timeout 240 'notify-send "Idle! locking soon..."' \
    timeout 300 'swaylock -f' \
    timeout 360 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
''
