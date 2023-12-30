{pkgs}:
pkgs.writeShellScriptBin "clicker" ''
  bin=${pkgs.ydotool}/bin/ydotool 
  "$bin"d &
  while true; do
    sleep 0.001 
    $bin click 0xC0
  done
''
