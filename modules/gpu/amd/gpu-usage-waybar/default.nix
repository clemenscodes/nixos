{pkgs}:
with pkgs;
  rustPlatform.buildRustPackage rec {
    pname = "gpu-usage-waybar";
    version = "0.1.2";
    src = fetchFromGitHub {
      owner = "cymenix";
      repo = pname;
      rev = "b92311709f29a28c3f4f52172ae82d7ea34d1eac";
      hash = "sha256-NY6Xv2yg1QJO7enzJjtYXb/Zd1pNAtr0wENDQwerJ5w=";
    };
    cargoHash = "sha256-TOV+0cB2OmtsixBBLGYod1YJckx9a2Ar+uJWcKGqM/0=";
  }
