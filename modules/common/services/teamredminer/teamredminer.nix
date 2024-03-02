{pkgs}:
with pkgs;
  stdenv.mkDerivation rec {
    name = "teamredminer";
    version = "v0.10.18";

    src = fetchTarball {
      url =  "https://github.com/todxx/${name}/releases/download/${version}/${name}-${version}-linux.tgz";
      sha256 = "0q41gjibzbl51arz09kh1bx62w0adh98ww7ixk8cplj0kwsw52wf";
    };

    installPhase = ''
      mkdir -p $out/bin
      cp -r $src/${name} $out/bin/${name}
    '';
  }
