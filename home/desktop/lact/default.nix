{
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = ["${import ../../../modules/services/desktop/lact {inherit pkgs lib;}}"];
  };
}
