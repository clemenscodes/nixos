{pkgs,...}: {
  home = {
    packages = with pkgs; [
      ydotool
    ];
  };
}
