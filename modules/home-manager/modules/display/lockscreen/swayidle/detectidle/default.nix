{pkgs}:
pkgs.writeShellScriptBin "detectidle" ''
  ${pkgs.swayidle}/bin/swayidle -w \
    timeout 2400 '${pkgs.libnotify}/bin/notify-send "Idle! locking soon..."' \
    timeout 3000 'lockout' \
    timeout 4200 '${pkgs.systemd}/bin/systemctl suspend'
''
