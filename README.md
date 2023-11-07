# NixOS Rice

- Kernel: latest
- Terminal: Kitty
- Shell: zsh / starship prompt
- Text Editor: Neovim
- Window Manager/Compositor: Hyprland 
- App Launcher: Rofi
- Status Bar: Waybar
- File Browser: lf
- Browser: Brave
- PDF Viewer: zathura

## Installation

```sh
git clone git@github.com:clemenscodes/nixos.git $XDG_CONFIG_HOME
cp /etc/nixos/hardware-configuration.nix $XDG_CONFIG_HOME/nixos/machines/<MACHINE>/
sudo nixos-rebuild switch --flake $XDG_CONFIG_HOME/nixos/#<MACHINE>
sudo reboot now
```

You will probably want to adjust your username in `flake.nix` before switching 
and add your own machine config by importing only what you want. 

