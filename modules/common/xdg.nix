{ pkgs, ... }: {
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
      wlr = {
        enable = true;
      };
      xdgOpenUsePortal = true;
    };
  };
}
