{pkgs, ...}: {
  imports = [
    ./launcher.nix
  ];
  home = {
    packages = with pkgs; [
      discord
    ];
  };
}
