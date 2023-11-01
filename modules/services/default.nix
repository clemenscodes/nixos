{ ... }: { 
  imports = [ 
    ./xserver.nix
    ./sound.nix
    ./picom.nix
    ./printing.nix
  ];
}
