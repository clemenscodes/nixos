{ pkgs }: 
let 
  imgLink = "https://raw.githubusercontent.com/clemenscodes/nixos/main/assets/wallpaper/ring.jpeg";
  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "1bcwsqkffl6gmr2vn69bk1izzz6r8fdjv4l8vc880q63zgh3vi83";
  };
in
pkgs.stdenv.mkDerivation {
  name = "catppuccin-macchiato";
  
  src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "sddm";
    rev = "a13cf43fe05a6c463a7651eb2d96691a36637913";
    sha256 = "0apbnykpjzfkhpk16fy74sbk27i0p1v59zgrwj38lw9wvqgb0axp";
  };
  
  installPhase = ''
    mkdir -p $out
    cp -R ./src/catppuccin-macchiato/* $out
    cp -R ${image} $out/backgrounds/wall.jpeg
    cat <<EOF > "$out/theme.conf"
      [General]
      Font="Iosevka Nerd Font"
      FontSize=14
      ClockEnabled="true"
      CustomBackground="true"
      LoginBackground="true"
      Background="backgrounds/wall.jpeg"
      
      # DON'T CHANGE THESE
      rosewater = "#f4dbd6"
      flamingo  = "#f0c6c6"
      pink      = "#f5bde6"
      mauve     = "#c6a0f6"
      red       = "#ed8796"
      maroon    = "#ee99a0"
      peach     = "#f5a97f"
      yellow    = "#eed49f"
      green     = "#a6da95"
      teal      = "#8bd5ca"
      sky       = "#91d7e3"
      sapphire  = "#7dc4e4"
      blue      = "#8aadf4"
      lavender  = "#b7bdf8"
      text      = "#cad3f5"
      subtext1  = "#b8c0e0"
      subtext0  = "#a5adcb"
      overlay2  = "#939ab7"
      overlay1  = "#8087a2"
      overlay0  = "#6e738d"
      surface2  = "#5b6078"
      surface1  = "#494d64"
      surface0  = "#363a4f"
      base      = "#24273a"
      mantle    = "#1e2030"
      crust     = "#181926"
    EOF
    '';
}
