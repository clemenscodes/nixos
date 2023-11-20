{ pkgs }:

pkgs.writeShellScriptBin "sshagent" ''
  eval "$(${pkgs.ssh-agent}/bin/ssh-agent -s)" && ${pkgs.ssh-agent}/bin/ssh-add
''
