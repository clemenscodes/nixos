{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      (spotdl.overrideAttrs(oldAttrs: { version = "4.1.1"; }))
    ];
  };
}
