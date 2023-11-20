# NixOS Rice

- Kernel: `latest`
- Terminal: `kitty`
- Shell: `zsh`
- Prompt: `starship`
- Email Client: `neomutt`
- Text Editor: `nvim`
- Display Server: `wayland`
- Display Manager: `sddm`
- Compositor: `hyprland`
- App Launcher: `rofi`
- Status Bar: `waybar`
- File Browser: `lf`
- Browser: `firefox`
- PDF Viewer: `zathura`
- Notification Center: `swaynotificationcenter`
- Music Player: `mpd`
- Music Player Frontend: `ncmpcpp`
- Video Player: `mpv`
- Bootloader: `grub`
- Process Manager: `btop`
- Password Manager: `bitwarden`
- Font: `iosevka`
- Wallpaper Engine: `swww`
- Powermenu: `wlogout`

## Prerequisites

SOPS is used for various services and is recommended to be setup before installing.

To get sops working, you will first need to create a new SSH key pair or put your existing SSH key at `~/.ssh/id_ed25519`.

Now clone the repository in the expected location `~/.config/nixos`

```sh
mkdir -p ~/.config
nix-shell -p git --run "git clone https://github.com/clemenscodes/nixos.git ~/.config/nixos"
cd ~/.config/nixos
```

Then you can run these commands to generate the keys used by sops.

```sh
mkdir -p ~/.config/sops/age
nix-shell -p ssh-to-age --run "ssh-to-age -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt"
nix-shell -p age --run "age-keygen -y ~/.config/sops/age/keys.txt"
cd ~/.config/nixos/secrets || exit
nix-shell -p sops --run "sops secrets.yaml"
```

You will land in the sops editor where you can define your secrets.

The currently used secrets are:
  - user password: `password`
  - wifi secrets: `wifi`
  - email passwords: `email/{email-account-name}/password`
  - github_token: `github_token`

System secrets are managed in `./machines/default.nix`.

User secrets are managed in `./modules/common/home/desktop/sops/default.nix`.

Everytime a secret is added or removed it needs to be added or removed accordingly in the mentioned files as well.

An example secrets.yaml:

```yaml
password: <your-secure-password>
wifi: |
  home_uuid=<your-ssid>
  home_psk=<your-wifi-psk>
email:
  <your-email-address>:
    password: <your-email-password>
github_token: <your-github-pat>
```

### Network Configuration

You will want to edit `./modules/common/networking.nix`
to only include networks that are relevant to you.

```nix
...
{
  ...
  environmentFile = config.sops.secrets.wifi.path;
  networks = {
    "@home_uuid@" = {
      priority = 1;
      pskRaw = "@home_psk@";
    };
    ...
  };
}
...
```

### Email Configuration

Similarly, you will want to edit `./modules/common/home/desktop/email/default.nix`
to only include email accounts relevant to you.

```nix
...
{
  accounts = {
    email = {
      maildirBasePath = "/home/${user}/.local/share/mail";
      <your-email-address> = mkEmailAccount {
        primary = true;
        address = "<your-email-address";
        realName = "<your-name>";
        userName = "<your-email-username>";
        smtpHost = "<your-smtp-host>";
        smtpPort = <your-smtp-port>; 
        imapHost = "<your-imap-host"; 
        imapPort = <your-imap-port>; 
        secretName = "email/<your-email-address>/password";
      };
      ...
    };
  };
}
...
```

For convenience, you can add a macro to quickly switch between accounts:

```nix
...
{
  ...
  macros = [
    {
      map = [ "index" "pager" ];
      key = "i1";
      action = "<sync-mailbox><enter-command>source /home/${user}/.config/neomutt/<YOUR_EMAIL_ADDRESS><enter><change-folder>!<enter>;<check-stats>";
    }
    ...
  ];
}
...
```

### GitHub Configuration

Add your GitHub PAT with sops as `github_token`. 
NixOS will then populate `GH_TOKEN=<your-github-pat>` into your shell environment.

### Hyprland Configuration

Hyprland has be configured to support your individual machines by adding a machine specific configuration at `./modules/common/home/desktop/hyprland/config/machine/<your-machine>.conf`.

## Installation

Create a new folder in `machines` for your individual machine.

```sh
mkdir ~/.config/nixos/machines/<your-machine>
```

Copy your hardware configuration in that folder.

```sh
sudo cp /etc/nixos/hardware-configuration.nix ~/.config/nixos/machines/<your-machine>
```

Next, write a `default.nix` file that imports your hardware configuration.
This file is where you can specify machine specific system configurations.

NOTE: If you use an NVIDIA card, you will want to import `../../modules/nvidia.nix` in that file as well.

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
in {
  ...
  <your-machine> = mkMachine {
    modulePath = ./<your-machine>;
    machine = "<your-machine>";
  };
}
```

Now switch to the new configuration.

```sh
nix-shell -p git --run "sudo nixos-rebuild switch --flake ~/.config/nixos/#<your-machine>"
```

Thats it, you can now reboot into the system.

```sh
sudo reboot now
```

After installing you will have a `switch` alias available that will build your machine configuration.
You will also have a `setupsops` script available to easily edit secrets.

### Further Steps

To make the best out of this, you will want to adjust the defaults like user, locale etc. in `flake.nix`.

- user: `clay`
- locale: `de`
- keyboard layout: `de`
- browser: `firefox`
- terminal: `kitty`
- editor: `nvim`
- timezone: `Europe/Berlin`
- hostname: `nixos`

