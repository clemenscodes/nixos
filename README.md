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

First clone the repository in the expected location `~/.config/nixos`

```sh
git clone git@github.com:clemenscodes/nixos.git ~/.config/nixos
```

Now create a new folder in `machines` for your individual machine

```sh
mkdir ~/.config/nixos/machines/<your-machine>
```

Copy your hardware configuration in that folder

```sh
sudo cp /etc/nixos/hardware-configuration.nix ~/.config/nixos/machines/<your-machine>
```

Next, write a `default.nix` file that imports your hardware configuration.
This file is where you can specify machine specific system configurations.

NOTE: If you use an nvidia card, you will want to import `../modules/nvidia.nix` in that file as well.

```sh
cat > ~/.config/nixos/machines/<your-machine>/default.nix <<EOF
{ ... }: {
  imports = [ ./hardware-configuration.nix ]; 
}
EOF
```

With that setup, all what is left is to add your machine configuration in the `machines/default.nix`.

```nix
...
//
in {
  ...
  <your-machine> = mkMachine {
    modulePath = ./<your-machine>;
    machine = "<your-machine>";
  };
}
```

Thats it, you can now reboot into the system

```sh
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

- Hyprland can be configured to support your individual machines by adding a machine specific configuration at `./modules/common/home/desktop/hyprland/config/machine/<your-machine>.conf`

