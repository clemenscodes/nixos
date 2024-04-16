{lib, ...}:
with lib; {
  imports = [
    ./amd
    ./nvidia
  ];
  options = {
    gpu = {
      enable = mkEnableOption "Enable GPU support";
    };
  };
}
