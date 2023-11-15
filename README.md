# NixOS Rice

- Kernel: latest
- Terminal: Kitty
- Shell: zsh / starship prompt
- Text Editor: Neovim
- Window Manager/Compositor: Hyprland 
- App Launcher: Rofi
- Status Bar: Waybar
- File Browser: lf
- Browser: Firefox
- PDF Viewer: zathura

## Installation

```sh
git clone git@github.com:clemenscodes/nixos.git $XDG_CONFIG_HOME
sudo cp /etc/nixos/hardware-configuration.nix $XDG_CONFIG_HOME/nixos/machines/<MACHINE>/
sudo nixos-rebuild switch --flake $XDG_CONFIG_HOME/nixos/#<MACHINE>
sudo reboot now
```

After installing you will have a `switch` alias available that will build your machine configuration.

To make the best out of this, you will want to adjust the definitions like user, locale etc. in `flake.nix`.

### Further Steps

Adjust these defaults to suit your purposes.

- user: `clay`
- locale: `de`
- keyboard layout: `de`
- browser: `firefox`
- terminal: `kitty`
- editor: `nvim`
- timezone: `Europe/Berlin`

#### SOPS

To get sops working, you will first need to create your SSH keys at `~/.ssh/id_ed25519`.
Then you can run the helper script to generate the keys used by sops.

```sh
./home/scripts/setupsops
```

You will land in the sops editor where you can define your secrets.

The currently used secrets are:
  - user password: `password`
  - wifi secrets: `wifi`
  - email passwords: `email/{context}/password`

### Additional Considerations

- Nvidia GPUs are supported by importing the `./modules/nvidia.nix` module into your machine configuration
- Hyprland can be configured to support your individual machines by adding a machine specific configuration at `./modules/common/home/desktop/hyprland/config/machine/<MACHINE>.conf`

