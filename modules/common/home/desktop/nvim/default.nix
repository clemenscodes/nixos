{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      python3
      jdt-language-server
    ];
  };
  xdg = {
    configFile = {
      nvim = {
        source = ./config;
        recursive = true;
      };
      "nvim/lua" = {
        source = ./config/lua;
        recursive = true;
      };
      "nvim/lua/config" = {
        source = ./config/lua/config;
        recursive = true;
      };
      "nvim/lua/plugins" = {
        source = ./config/lua/plugins;
        recursive = true;
      };
      "nvim/lua/util" = {
        source = ./config/lua/util;
        recursive = true;
      };
    };
  };
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withRuby = true;
      withPython3 = true;
      extraPython3Packages = ps: with ps; [ pip ];
      extraPackages = with pkgs; [
        nodejs
        eza
        ripgrep
        fd
        wl-clipboard
        gcc
        gnumake
        tree-sitter
        wget
        zip
        unzip
        go
        php82Packages.composer
        php
        cargo
        luajitPackages.luarocks
        zulu
        julia
        java-language-server
      ];
    };
  };
}
