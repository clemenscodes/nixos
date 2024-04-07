{
  nixpkgs,
  lib,
  system,
  ...
}: let
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["discord"];
    };
  };
in {
  imports = [
    ./launcher.nix
  ];
  home = {
    packages = [pkgs.discord];
  };
}
