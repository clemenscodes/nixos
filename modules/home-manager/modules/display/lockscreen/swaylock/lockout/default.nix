{pkgs}:
pkgs.writeShellScriptBin "lockout" ''
  if pgrep -x "${pkgs.swaylock}/bin/swaylock" > /dev/null; then
    exit 0
  fi
  ${pkgs.swaylock}/bin/swaylock -f
''
