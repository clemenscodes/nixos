{
  nixpkgs,
  lib,
  system,
  ...
}: let
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["spotify"];
    };
  };
in {
  home = {
    packages = [pkgs.spotify];
  };
}
