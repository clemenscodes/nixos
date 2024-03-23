{pkgs}:
with pkgs;
  stdenv.mkDerivation rec {
    name = "nanominer";
    version = "3.8.12";
    tarball = "${name}-linux-${version}.tar.gz";

    src = fetchurl {
      url = "https://github.com/nanopool/${name}/releases/download/v${version}/${tarball}";
      sha256 = "1fwfh21g410yywi641rmzyr4pda262njabbywhwfsf6nkck2x69m";
    };

    unpackPhase = ''
      echo "Skipping unpackPhase, unpacking in installPhase"
    '';

    installPhase = ''
      tmp=$(mktemp -d)
      cp -r $src ''$tmp
      tar xvf ''$tmp/*-''$tarball -C ''$tmp
      mkdir -p $out/bin
      ls -la ''$tmp
      cp -r ''$tmp/${name} $out/bin/${name}
    '';
  }
