{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
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
      (python311.withPackages(ps: with ps; [pip]))
    ];
  };
  xdg = {
    configFile = {
      nvim = {
        source = ./config;
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
    };
  };
}
