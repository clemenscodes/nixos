{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
    ];
  };
  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
    platformTheme = "gtk";
  };
}
