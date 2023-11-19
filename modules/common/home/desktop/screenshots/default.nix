{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      grim
      slurp
      imagemagick
      swappy
    ];
  };
}
