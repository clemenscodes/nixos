{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      xwaylandvideobridge
    ];
  };
}
