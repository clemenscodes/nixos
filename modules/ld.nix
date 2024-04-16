{
  pkgs,
  nix-ld,
  ...
}: {
  imports = [
    nix-ld.nixosModules.nix-ld
  ];
  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        webkitgtk_4_1
        gtk3
        cairo
        gdk-pixbuf
        glib.dev
        dbus
        openssl_3
        stdenv.cc.cc
        systemd
        pkg-config
      ];
    };
  };
}
