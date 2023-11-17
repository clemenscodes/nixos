{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      grim
      slurp
      imagemagick_light
      swappy
    ];
  };
}
