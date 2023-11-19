{ pkgs }: pkgs.stdenv.mkDerivation {
  name = "catppuccin-macchiato";

  src = pkgs.fetchFromGitHub {
    owner = "clemenscodes";
    repo = "sddm-catppuccin-macchiato";
    rev = "523818d3073982ec8cd646f2be9038ad6e84583d";
    sha256 = "1df8r95zjbldf45jyn3wlyi0rbf0nvsgfi26zd3dl12zvakjdx73";
  };
 
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out
  '';
}
