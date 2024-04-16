{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      grim
      slurp
      swappy
    ];
  };
  xdg = {
    configFile = {
      "swappy/config" = {
        text = ''
          [Default]
          save_dir=${config.xdg.dataHome}/images/screenshots
        '';
      };
    };
  };
}
