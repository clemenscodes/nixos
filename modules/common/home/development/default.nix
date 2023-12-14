{pkgs, ...}: {
  imports = [
    ./vscode
  ];
  home = {
    packages = with pkgs; [
      gdb
      pwndbg
      cmake
      cmake-format
      clang-tools
      nasm
      cloc
      nodejs_20
      prettierd
      nodePackages.pnpm
      nodePackages.yarn
      bun
      jetbrains.idea-ultimate
      zulu
    ];
  };
}
