{
  pkgs,
  config,
  ...
}: {
  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableZshIntegration = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
  programs = {
    gpg = {
      enable = true;
      homedir = "${config.xdg.configHome}/gnupg";
    };
  };
}
