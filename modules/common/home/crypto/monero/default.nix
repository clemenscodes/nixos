{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      monero-gui
      monero-cli
      p2pool
      xmrig
    ];
  };
}
