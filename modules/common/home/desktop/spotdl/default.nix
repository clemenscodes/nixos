{ pkgs, system, ... }: 
let
  # spotdl v4.1.8 is latest version that is not broken
  spotdl = (import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/8cad3dbe48029cb9def5cdb2409a6c80d3acfe2e.tar.gz";
    sha256 = "181ad740l2fy6phsz45jlvhnshhz4nvvl900vm1kvn9bhlc1ih95";
  }) { inherit (pkgs) system; }).spotdl;
in
{
  home = {
    packages = with pkgs; [
      spotdl
    ];
  };
}
