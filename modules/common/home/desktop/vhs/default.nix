{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      vhs
    ];
  };
}
