{ ... }: { 
  imports = [ 
    ./sddm
    ./sound.nix
    ./printing.nix
    ./xremap.nix
    ./auto-cpufreq.nix
    ./dbus.nix
  ];
}
