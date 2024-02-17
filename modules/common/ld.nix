{pkgs, ...}: {
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
      ];
    };
  };
}
