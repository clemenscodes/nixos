{ pkgs }:

pkgs.writeShellScriptBin "wallpaper" ''
  ${pkgs.swww}/bin/swww init && ${pkgs.swww}/bin/swww img $XDG_DATA_HOME/images/wallpaper/ring.jpeg  
''
