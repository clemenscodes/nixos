{
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = ["${import ../../../services/desktop/lact {inherit pkgs lib;}}"];
  };
}
