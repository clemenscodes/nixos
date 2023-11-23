{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      networkmanagerapplet
      iwgtk
    ];
  };
  services = {
    network-manager-applet = {
      enable = true;
    };
  };
}
