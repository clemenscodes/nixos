{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      swayimg
    ];
  };
}
