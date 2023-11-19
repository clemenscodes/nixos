{ ... }: { 
  imports = [ 
    ./sddm
    ./bluetooth.nix
    ./sound.nix
    ./printing.nix
    ./xremap.nix
    ./auto-cpufreq.nix
    ./dbus.nix
  ];
}
