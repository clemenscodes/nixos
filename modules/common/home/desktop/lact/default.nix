{pkgs, lib, ...}: {
  home = {
    packages = ["${import ../../../services/lact {inherit pkgs lib;}}"];
  };
}
