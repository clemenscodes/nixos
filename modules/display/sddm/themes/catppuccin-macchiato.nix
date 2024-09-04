{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "catppuccin-macchiato";

  src = pkgs.fetchFromGitHub {
    owner = "clemenscodes";
    repo = "sddm-catppuccin-macchiato";
    rev = "be95bcfae18faff232c5b3ce06ab3014bb45bc51";
    sha256 = "06h3b0lp9c3xmgs1hdv17yssxplknpzhygm90n6dcg51j7vf49n7";
  };

  installPhase = ''
    mkdir -p $out
    cp -R ./* $out
  '';
}
