{pkgs, ...}: {
  home = {
    packages = ["${import ./manix.nix {inherit pkgs;}}"];
  };
}
