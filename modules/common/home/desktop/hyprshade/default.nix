{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      hyprshade
    ];
  };
  xdg = {
    configFile = {
      "hyprshade/config.toml" = {
        text = ''
          [[shades]]
          name = "vibrance"
          default = true
          
          [[shades]]
          name = "blue-light-filter"
          start_time = 19:00:00
          end_time = 06:00:00
        '';
      };
    };
  };
}
