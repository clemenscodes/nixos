{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      gdb
      pwndbg
      cmake
      cmake-format
      clang-tools
      nasm
      nodejs_20
      nodePackages.pnpm
      nodePackages.yarn
      bun
      jetbrains.idea-ultimate
      zulu
    ];
  };
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };
}
