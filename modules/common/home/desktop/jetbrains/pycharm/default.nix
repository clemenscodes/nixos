{
  nixpkgs,
  system,
  ...
}: let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  home = {
    packages = with pkgs; [
      jetbrains.pycharm-community
    ];
  };
}
