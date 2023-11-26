{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      glaxnimate
      kdenlive
    ];
  };
}
