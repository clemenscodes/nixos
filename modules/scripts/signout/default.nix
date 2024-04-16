{pkgs}:
pkgs.writeShellScriptBin "signout" ''
  sudo pkill corectrl
  ${pkgs.systemd}/bin/loginctl kill-user $USER
''
