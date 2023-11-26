{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      etcher
    ];
  };
}
