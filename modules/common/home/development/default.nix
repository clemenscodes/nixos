{pkgs, ...}: {
  imports = [
    ./vscode
  ];
  home = {
    packages = with pkgs; [
      jetbrains.idea-ultimate
      zulu
    ];
  };
}
