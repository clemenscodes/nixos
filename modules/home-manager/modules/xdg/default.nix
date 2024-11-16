{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules;
  osCfg = osConfig.modules;
in
  with lib; {
    options = {
      modules = {
        xdg = {
          enable = mkEnableOption "Enable XDG in home" // {default = osCfg.enable;};
        };
      };
    };
    config = mkIf (osCfg.enable && cfg.enable && cfg.xdg.enable) {
      xdg = {
        enable = cfg.xdg.enable;
        userDirs = let
          home = config.home.homeDirectory;
          local = "${home}/.local";
        in {
          enable = true;
          createDirectories = true;
          music = "${home}/music";
          documents = "${local}/share/documents";
          pictures = "${local}/share/images";
          videos = "${local}/share/videos";
          desktop = "${local}/share/desktop";
          download = "${local}/share/downloads";
          publicShare = "${local}/share/public";
          templates = "${local}/share/templates";
          extraConfig = {
            XDG_BIN_HOME = "${local}/bin";
          };
        };
        dataFile = {
          "face" = {
            source = ./assets/face;
            recursive = true;
          };
          "chars" = {
            source = ./assets/chars;
            recursive = true;
          };
          "fonts" = {
            source = ./assets/fonts;
            recursive = true;
          };
          "images/wallpaper" = {
            source = ./assets/wallpaper;
            recursive = true;
          };
          "images/svg" = {
            source = ./assets/svg;
            recursive = true;
          };
          "notes/README.md" = {
            text = ''
              # Notes

              - where general notes are stored
              - run `notes` to cd into this directory
            '';
          };
          "images/screenshots/README.md" = {
            text = ''
              # Screenshots

              - This is the directory where screenshots will be saved by swappy
              - run `sss to cd into this directory
            '';
          };
          "nvim/undo/README.md" = {
            text = ''
              # Neovim undo direcotry

              - This is the directory where neovim stores its undo history
            '';
          };
          "isos/README.md" = {
            text = ''
              # Iso images

              - store iso images here
              - run `isos` to cd into this directory
            '';
          };
        };
        configFile = {
          nixpkgs = {
            text =
              /*
              nix
              */
              ''
                {
                  packageOverrides = pkgs: {
                    nur =
                      import (builtins.fetchTarball {
                        url = "https://github.com/nix-community/NUR/archive/3a6a6f4da737da41e27922ce2cfacf68a109ebce.tar.gz";
                        sha256 = "04387gzgl8y555b3lkz9aiw9xsldfg4zmzp930m62qw8zbrvrshd";
                      }) {
                        inherit pkgs;
                      };
                  };
                }
              '';
          };
        };
      };
    };
  }
