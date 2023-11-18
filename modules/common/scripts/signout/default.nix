{ pkgs }:

pkgs.writeShellScriptBin "signout" ''
  ${pkgs.systemd}/bin/loginctl kill-user $USER
''
