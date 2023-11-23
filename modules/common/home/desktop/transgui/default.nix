{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      transgui
    ];
  };
}
