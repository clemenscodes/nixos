{lib, ...}:
with lib; {
  imports = [
    ./amd
    ./nvidia
  ];
  options = {
    modules = {
      gpu = {
        enable = mkEnableOption "Enable GPU support" // {default = false;};
        vendor = mkOption {
          type = types.enum ["amd" "nvidia"];
          default = "amd";
        };
      };
    };
  };
}
