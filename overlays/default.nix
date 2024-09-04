{
  inputs,
  nixpkgs,
  system,
}: let
  headlessOverlays = import ./headless {inherit inputs nixpkgs system;};
  guiOverlays = import ./gui {inherit inputs;};
in
  headlessOverlays
  ++ guiOverlays
  ++ [
    (final: prev: {
      inherit (import (inputs.nixos-unstable-small) {inherit system;}) xdg-desktop-portal-hyprland;
    })
  ]
