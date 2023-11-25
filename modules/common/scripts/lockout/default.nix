{ pkgs }: 

pkgs.writeShellScriptBin "lockout" ''
  if pgrep -x "swaylock" > /dev/null; then
    exit 0
  fi
  swaylock -f
''
