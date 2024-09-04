{
  nixpkgs,
  system,
  config,
  lib,
  ...
}: let
  cfg = config.modules.development.reversing;
  pkgs = import nixpkgs {
    inherit system;
    overlays = [
      (self: super:
        with super; {
          ghidra = ghidra.overrideAttrs (oldAttrs: {
            patches = oldAttrs.patches ++ [./powerpc.patch];
          });
          ps3GhidraScripts = stdenv.mkDerivation {
            name = "Ps3GhidraScripts";
            src = fetchurl {
              url = "https://github.com/clienthax/Ps3GhidraScripts/releases/download/1.069/ghidra_11.0_PUBLIC_20240204_Ps3GhidraScripts.zip";
              sha256 = "04iqfgz1r1a08r2bdd9nws743a7h9gdxqfdf3dxbx10xqnpnwny8";
            };
            nativeBuildInputs = [unzip];
            phases = "installPhase";
            installPhase = ''
              runHook preInstall

              mkdir -p $out/lib/ghidra/Ghidra/Extensions
              unzip -d $out/lib/ghidra/Ghidra/Extensions $src

              runHook postInstall
            '';
          };
        })
    ];
  };
in
  with lib; {
    options = {
      modules = {
        development = {
          reversing = {
            ghidra = {
              enable = mkEnableOption "Enable ghidra" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.ghidra.enable) {
      home = {
        packages =
          (with pkgs; [
            ghidra
            ps3GhidraScripts
          ])
          ++ (with pkgs.ghidra-extensions; [
            # gnudisassembler
            # sleighdevtools
            # machinelearning
            # ghidraninja-ghidra-scripts
          ]);
      };
    };
  }
