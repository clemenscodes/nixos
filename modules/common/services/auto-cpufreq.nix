{ pkgs, ... }: {
  systemd = {
    packages = with pkgs; [
      auto-cpufreq
    ];
  };
  services = {
    auto-cpufreq = {
      enable = true;
    };
  };
}
