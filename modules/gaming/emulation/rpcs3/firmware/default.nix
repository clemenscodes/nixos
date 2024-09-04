{pkgs}:
with pkgs;
  stdenv.mkDerivation {
    name = "ps3bios";
    src = fetchurl {
      url = "http://dus01.ps3.update.playstation.net/update/ps3/image/us/2024_0227_3694eb3fb8d9915c112e6ab41a60c69f/PS3UPDAT.PUP";
      sha256 = "1xw00fns2cvy75czq2z4pz2n45da5db7g98ybmrrdd9nj22bv55w";
    };
    phases = "installPhase";
    installPhase = ''
      mkdir -p $out $out/bios
      cp $src $out/bios/PS3UPDAT.PUP
    '';
  }
