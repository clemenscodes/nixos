{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      swayidle
      (import ../sway-audio-idle-inhibit {inherit pkgs;})
    ];
  };
}
