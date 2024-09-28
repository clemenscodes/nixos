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

