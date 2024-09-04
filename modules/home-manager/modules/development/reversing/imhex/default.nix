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
      (self: super: {
        glfw = super.glfw.overrideAttrs (finalAttrs: previousAttrs:
          with super; {
            postPatch = lib.optionalString stdenv.isLinux ''
              substituteInPlace src/wl_init.c \
                --replace-fail "libxkbcommon.so.0" "${lib.getLib libxkbcommon}/lib/libxkbcommon.so.0" \
                --replace-fail "libdecor-0.so.0" "${lib.getLib libdecor}/lib/libdecor-0.so.0" \
                --replace-fail "libwayland-client.so.0" "${lib.getLib wayland}/lib/libwayland-client.so.0" \
                --replace-fail "libwayland-cursor.so.0" "${lib.getLib wayland}/lib/libwayland-cursor.so.0" \
                --replace-fail "libwayland-egl.so.1" "${lib.getLib wayland}/lib/libwayland-egl.so.1"
            '';
          });
        imhex = super.imhex.overrideAttrs (finalAttrs: previousAttrs: let
          patterns_version = "1.35.3";
          patterns_src = super.fetchFromGitHub {
            owner = "WerWolv";
            repo = "ImHex-Patterns";
            rev = "ImHex-v${patterns_version}";
            hash = "sha256-h86qoFMSP9ehsXJXOccUK9Mfqe+DVObfSRT4TCtK0rY=";
          };
        in rec {
          version = "1.35.3";
          src = super.fetchFromGitHub {
            fetchSubmodules = true;
            owner = "WerWolv";
            repo = previousAttrs.pname;
            rev = "v${version}";
            hash = "sha256-8vhOOHfg4D9B9yYgnGZBpcjAjuL4M4oHHax9ad5PJtA=";
          };
          nativeBuildInputs = with super; [
            autoPatchelfHook
            cmake
            llvm
            python3
            perl
            pkg-config
            rsync
          ];
          autoPatchelfIgnoreMissingDeps = ["*.hexpluglib"];
          appendRunpaths = [
            (lib.makeLibraryPath [super.libGL])
            "${placeholder "out"}/lib/imhex/plugins"
          ];
          postInstall = ''
            mkdir -p $out/share/imhex
            rsync -av --exclude="*_schema.json" ${patterns_src}/{constants,encodings,includes,magic,patterns} $out/share/imhex
          '';
        });
      })
    ];
  };
in
  with lib; {
    options = {
      modules = {
        development = {
          reversing = {
            imhex = {
              enable = mkEnableOption "Enable imhex" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.imhex.enable) {
      home = {
        packages = with pkgs; [imhex];
      };
    };
  }
