{pkgs, ...}: let
  corectrl =
    (import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
      sha256 = "1l2hq1n1jl2l64fdcpq3jrfphaz10sd1cpsax3xdya0xgsncgcsi";
    }) {inherit (pkgs) system;})
    .corectrl;
in {
  home = {
    packages = [corectrl];
  };
  xdg = {
    configFile = {
      "corectrl/corectrl.ini" = {
        text = ''
          [General]
          startOnSysTray=true
        '';
      };
    };
  };
}
