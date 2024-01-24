{config, ...}: {
  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableZshIntegration = true;
      pinentryFlavor = "gnome3";
    };
  };
  programs = {
    gpg = {
      enable = true;
      homedir = "${config.xdg.configHome}/gnupg";
    };
  };
}
