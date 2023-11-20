{ pkgs }:

pkgs.writeShellScriptBin "sshagent" ''
  eval "$(${pkgs.openssh}/bin/ssh-agent -s)" && ${pkgs.openssh}/bin/ssh-add
''
