{lib, ...}: {...}: {
  imports = [
    ./amd
    ./nvidia
  ];
  options = {
    modules = {
      gpu = {
        enable = lib.mkEnableOption "Enable GPU support" // {default = false;};
        vendor = lib.mkOption {
          type = lib.types.enum ["amd" "nvidia"];
          default = "amd";
        };
      };
    };
  };
}
