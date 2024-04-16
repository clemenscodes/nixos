{pkgs}:
pkgs.writeShellScriptBin "fullscreenshot" ''
  ${pkgs.grim}/bin/grim $XDG_PICTURES_DIR/screenshots/'''$(${pkgs.busybox}/bin/date +%s).png
''
