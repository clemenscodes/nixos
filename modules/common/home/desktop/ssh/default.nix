{ ... }: {
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
