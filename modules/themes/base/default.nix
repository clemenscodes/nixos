{lib, ...}:
with lib; {
  options = {
    modules = {
      themes = {
        base = {
          enable = mkEnableOption "Enable base theme" // {default = cfg.enable;};
          background = mkOption {
            type = types.str;
            default = "282828";
          };
          foreground = mkOption {
            type = types.str;
            default = "d6dae4";
          };
          cursor = mkOption {
            type = types.str;
            default = "b9b9b9";
          };
          base00 = mkOption {
            type = types.str;
            default = "1f1f1f";
          };
          base01 = mkOption {
            type = types.str;
            default = "f71118";
          };
          base02 = mkOption {
            type = types.str;
            default = "2cc55d";
          };
          base03 = mkOption {
            type = types.str;
            default = "ecb90f";
          };
          base04 = mkOption {
            type = types.str;
            default = "61afef";
          };
          base05 = mkOption {
            type = types.str;
            default = "4e59b7";
          };
          base06 = mkOption {
            type = types.str;
            default = "0f80d5";
          };
          base07 = mkOption {
            type = types.str;
            default = "d6dae4";
          };
          base08 = mkOption {
            type = types.str;
            default = "d6dae4";
          };
          base09 = mkOption {
            type = types.str;
            default = "de342e";
          };
          base0A = mkOption {
            type = types.str;
            default = "1dd260";
          };
          base0B = mkOption {
            type = types.str;
            default = "f2bd09";
          };
          base0C = mkOption {
            type = types.str;
            default = "61afef";
          };
          base0D = mkOption {
            type = types.str;
            default = "524fb9";
          };
          base0E = mkOption {
            type = types.str;
            default = "0f7cda";
          };
          base0F = mkOption {
            type = types.str;
            default = "ffffff";
          };
        };
      };
    };
  };
}
