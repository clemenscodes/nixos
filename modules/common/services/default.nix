{...}: {
  imports = [
    ./sddm
    ./bluetooth.nix
    ./sound.nix
    ./printing.nix
    ./xremap.nix
    ./auto-cpufreq.nix
    ./udisks.nix
    ./gitlab-runner.nix
    ./dbus.nix
    ./transmission.nix
    ./gnome-keyring.nix
  ];
}
