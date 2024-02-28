{
  pkgs,
  lib,
}:
with pkgs;
  rustPlatform.buildRustPackage {
    pname = "lact";
    version = "0.5.3";

    src = fetchFromGitHub {
      owner = "ilya-zlobintsev";
      repo = "LACT";
      rev = "f1233c5b168c91955cb1a6453ce07f5cefcb03bc";
      hash = "sha256-/Jr4BdirNpukWaBo20O5PU9W8+I4WohllKzhga3RkCc=";
    };

    cargoHash = "sha256-fjX2v+ZH8D2pJvTtQU0/r5sdCTWOtiQDmYIfU9UDgCc=";

    nativeBuildInputs = [
      blueprint-compiler
      pkg-config
      wrapGAppsHook
    ];

    buildInputs = [
      gdk-pixbuf
      gtk4
      libdrm
      vulkan-loader
    ];

    checkFlags = [
      # tries and fails to initialize gtk
      "--skip=app::root_stack::thermals_page::fan_curve_frame::tests::set_get_curve"
    ];

    postPatch = ''
      substituteInPlace lact-daemon/src/server/system.rs \
        --replace 'Command::new("uname")' 'Command::new("${coreutils}/bin/uname")'

      substituteInPlace res/lactd.service \
        --replace ExecStart={lact,$out/bin/lact}

      substituteInPlace res/io.github.lact-linux.desktop \
        --replace Exec={lact,$out/bin/lact}

      pushd $cargoDepsCopy/pciid-parser
      oldHash=$(sha256sum src/lib.rs | cut -d " " -f 1)
      substituteInPlace src/lib.rs --subst-var-by hwdata ${hwdata}
      substituteInPlace .cargo-checksum.json \
        --replace $oldHash $(sha256sum src/lib.rs | cut -d " " -f 1)
      popd
    '';

    postInstall = ''
      install -Dm444 res/lactd.service -t $out/lib/systemd/system
      install -Dm444 res/io.github.lact-linux.desktop -t $out/share/applications
      install -Dm444 res/io.github.lact-linux.png -t $out/share/pixmaps
    '';

    postFixup = ''
      patchelf $out/bin/.lact-wrapped \
        --add-rpath ${lib.makeLibraryPath [vulkan-loader]}
    '';

    meta = with lib; {
      description = "Linux AMDGPU Controller";
      homepage = "https://github.com/ilya-zlobintsev/LACT";
      license = licenses.mit;
      maintainers = with maintainers; [figsoda];
      platforms = platforms.linux;
      mainProgram = "lact";
    };
  }
