{
  lib,
  config,
  ...
}:
with lib; {
  options = {
    modules = {
      machine = {
        kind = mkOption {
          type = types.enum ["desktop" "laptop" "server" "wsl"];
          default = "desktop";
        };
        name = mkOption {
          type = types.str;
          default = config.modules.machine.kind;
        };
      };
    };
  };
}
