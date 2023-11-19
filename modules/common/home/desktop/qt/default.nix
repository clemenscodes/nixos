{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      libsForQt5.qt5.qtwayland
      libsForQt5.polkit-kde-agent
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
