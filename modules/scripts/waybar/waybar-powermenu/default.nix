{pkgs}:
pkgs.writeShellScriptBin "waybar-powermenu" ''
  powermenu=$(echo)
  tooltip=$(echo)
  class=$(echo "powermenu")

  echo $powermenu
  echo $tooltip
  echo $class
''
