{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      gcc
      cmake
      gnumake
      gdb
      nasm
      clang-tools
    ];
  };
}
