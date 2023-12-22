{pkgs}:

pkgs.writeShellScriptBin "lastchaos" ''
  bin="$(find ~/.local/share/Steam/steamapps/compatdata -type f -name 'Launcher.exe' | head -n 1)"
  bindir=$(dirname "$bin")
  cd "$bindir"
  wine ./Launcher.exe
''
