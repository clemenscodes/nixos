{pkgs}:
pkgs.writeShellScriptBin "polkitagent" ''
  ${pkgs.libsForQt5.polkit-kde-agent}/libexec/.polkit-kde-authentication-agent-1-wrapped
''
