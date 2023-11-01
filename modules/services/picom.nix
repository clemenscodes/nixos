{...}: {
  services = {
    picom = {
      enable = true;
      activeOpacity = 0.90;
      inactiveOpacity = 0.8;
      fade = true;
      fadeDelta = 5;
      opacityRules = [
        "100:fullscreen"
        "90:class_g = 'kitty' && focused"
        "90:class_g = 'kitty' && !focused"
        "100:class_g = 'Brave-browser' && focused"
        "100:class_g = 'Brave-browser' && !focused"
      ];
      shadow = true;
      shadowOpacity = 0.75;
    };
  };
}
