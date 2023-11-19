{ pkgs }:

pkgs.writeShellScriptBin "waybar-reload" ''
  ${pkgs.killall}/bin/killall -SIGUSR2 .waybar-wrapped
''
