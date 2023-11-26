{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      pup
    ];
  };
}
