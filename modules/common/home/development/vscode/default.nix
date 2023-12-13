{pkgs, ...}: {
  imports = [
    ./keybindings.nix
    ./settings.nix
    ./extensions.nix
    ./launcher.nix
  ];
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
    };
  };
}
