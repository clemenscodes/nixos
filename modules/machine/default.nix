{lib, ...}: {config, ...}: {
  options = {
    modules = {
      machine = {
        kind = lib.mkOption {
          type = lib.types.enum ["desktop" "laptop" "server" "wsl"];
          default = "desktop";
        };
        name = lib.mkOption {
          type = lib.types.str;
          default = config.modules.machine.kind;
        };
      };
    };
  };
}
