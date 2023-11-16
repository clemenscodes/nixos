{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      swayidle
    ];
  };
}
