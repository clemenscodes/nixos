{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      gnome.gnome-keyring
    ];
  };
  services = {
    gnome-keyring = {
      enable = true;
      components = [
        "ssh"
        "secrets"
      ];
    };
    ssh-agent = {
      enable = true;
    };
  };
}
