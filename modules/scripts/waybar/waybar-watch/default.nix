{pkgs}:
pkgs.writeShellScriptBin "waybar-watch" ''
  CONFIG_FILES="$HOME/.config/waybar/config $HOME/.config/waybar/style.css"
  trap "killall .waybar-wrapped" EXIT
  while true; do
    ${pkgs.util-linux}/bin/logger -i "$0: Starting waybar in the background..."
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.util-linux}/bin/logger -i "$0: Started waybar PID=$!. Waiting for modifications to ''${CONFIG_FILES}..."
    ${pkgs.inotify-tools}/bin/inotifywait -e modify ''${CONFIG_FILES} 2>&1 | ${pkgs.util-linux}/bin/logger -i
    ${pkgs.libnotify}/bin/notify-send "$0: inotifywait returned $?." "Reloading waybar..."
    ${pkgs.killall}/bin/killall .waybar-wrapped 2>&1 | ${pkgs.util-linux}/bin/logger -i
    ${pkgs.util-linux}/bin/logger -i "$0: killall waybar returned $?, wait a sec..."
    ${pkgs.coreutils}/bin/sleep 1
  done
''
