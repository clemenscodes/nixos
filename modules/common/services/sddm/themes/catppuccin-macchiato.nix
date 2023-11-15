{ pkgs }: pkgs.stdenv.mkDerivation {
  name = "catppuccin-macchiato";
  
  src = pkgs.fetchFromGitHub {
    owner = "clemenscodes";
    repo = "sddm-catppuccin-macchiato";
    rev = "1e4f3bc4487d83c9d9eff76e6185ff656c22e083";
    sha256 = "0pvvdyjvi3ma0sfw8cc4k8ylq379d7pn0qkxf4n66bc9zlmjk4ww";
  };
  
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out
  '';
}
