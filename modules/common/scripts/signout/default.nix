{pkgs}:
pkgs.writeShellScriptBin "signout" ''
  pkill corectrl
  ${pkgs.systemd}/bin/loginctl kill-user $USER
''
