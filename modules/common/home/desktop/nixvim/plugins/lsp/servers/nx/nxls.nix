{pkgs}:
with pkgs;
  buildNpmPackage rec {
    name = "nxls";
    version = "1.7.0";

    src = fetchFromGitHub {
      owner = "clemenscodes";
      repo = name;
      rev = "32bbe82b1f65a85960daa56b5d8280ad067a2f0a";
      hash = "sha256-oLzyqx5q+2p4qoL6PMN3CN/B4Fq7zST1oD3ZqGaKVi4=";
    };

    npmDepsHash = "sha256-Uz6/MfeGZSJNoLO6nCxtKcpOVrhWgH7elNFMNuuSg6I=";

    dontNpmBuild = true;

    installPhase = ''
      npm install
      mkdir $out
      cp -r ./* $out
      chmod +x -R $out/bin
    '';
  }
