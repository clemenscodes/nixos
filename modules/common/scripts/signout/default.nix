{ pkgs, user }:

pkgs.writeShellScriptBin "signout" ''
  ${pkgs.systemd}/bin/loginctl kill-user $(user)
''
