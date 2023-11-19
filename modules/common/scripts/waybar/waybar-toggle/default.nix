{ pkgs }:

pkgs.writeShellScriptBin "waybar-toggle" ''
  ${pkgs.killall}/bin/killall -SIGUSR1 .waybar-wrapped
''
