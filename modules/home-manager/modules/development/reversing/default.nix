{lib, ...}:
with lib; {
  imports = [
    ./ghidra
    ./ida
    ./imhex
  ];
  options = {
    modules = {
      development = {
        reversing = {
          enable = mkEnableOption "Enable reversing support" // {default = false;};
        };
      };
    };
  };
}
