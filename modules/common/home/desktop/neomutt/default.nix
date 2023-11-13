{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      mutt-wizard
      pass-wayland
      isync
      msmtp
      abook
    ];
  };
  programs = {
    neomutt = {
      enable = true;
      vimKeys = true;
      sidebar = {
        enable = true;
      };
      binds = [];
      settings = {};
      extraConfig = ''
      '';
    };
  };
}
