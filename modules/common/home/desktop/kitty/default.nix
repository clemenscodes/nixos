{ themes, ... }: {
  programs = {
    kitty = {
      enable = true;
      shellIntegration = {
        enableZshIntegration = true;
      };
      font = {
        name = "Iosevka Nerd Font";
        size = 14;
      };
      settings = with themes.custom; {
        dynamic_background_opacity = "yes";
        enable_audio_bell = false;
        shell = "zsh";
        confirm_os_window_close = 0;
        selection_background = "#${base00}";
        background = "#${background}";
        foreground = "#${foreground}";
        cursor = "#${cursor}";
        color0 = "#${base00}";
        color1 = "#${base01}";
        color2 = "#${base02}";
        color3 = "#${base03}";
        color4 = "#${base04}";
        color5 = "#${base05}";
        color6 = "#${base06}";
        color8 = "#${base08}";
        color7 = "#${base07}";
        color9 = "#${base09}";
        color10 = "#${base0A}";
        color11 = "#${base0B}";
        color12 = "#${base0C}";
        color13 = "#${base0D}";
        color14 = "#${base0E}";
        color15 = "#${base0F}";
      };
    };
  };
}
