{ inputs, config, pkgs, user, themes, ... }: { 
  imports = [ 
    ./hardware-configuration.nix 
    ../../modules
    ../../modules/nvidia.nix
    ../../modules/networking.nix
  ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/${user}/.config/sops/age/keys.txt";
      sshKeyPaths = [ "/home/${user}/.ssh/id_ed25519" ];
    };
    secrets = {
      password = {};
    };
  };

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      enableNvidiaPatches = true;
      xwayland = {
        enable = true;
      };
    };
    zsh = {
      enable = true;
      shellAliases = {
        update = "cd $HOME/.config/nixos && git pull";
        switch = "update && sudo nixos-rebuild switch --flake ./#desktop";
      };
      loginShellInit = ''
        export GDK_BACKEND=wayland,x11
        export GBM_BACKEND=nvidia-drm
        export SDL_VIDEODRIVER=wayland
        export CLUTTER_BACKEND=wayland
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export LIBVA_DRIVER_NAME=nvidia
        export __GL_GSYNC_ALLOWED=1
        export __GL_VRR_ALLOWED=1
      '';
    };
  };
}
