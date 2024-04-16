{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      stockfish
    ];
  };
}
