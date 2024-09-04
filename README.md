# NixOS

This flake exposes my configuration as a NixOS Module.

It provides a full system with sane default options.

## Usage

A minimal example in a `flake.nix`

```nix
{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nixos = {
      url = "github:clemenscodes/nixos";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
  };
  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        inherit (inputs) nixpkgs;
        inherit (nixpkgs) lib;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [inputs.nixos.overlays.${system}.default]
        };
      in {
        nixosConfigurations = {
          nixos = lib.nixosSystem {
            specialArgs = {inherit inputs nixpkgs system pkgs;};
            modules = [
              ./configuration.nix
              ./hardware-configuration.nix
              inputs.nixos.nixosModules.${system}.default
            ];
          };
        };
      }
    );
}

```

## Software used

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
- Theme: `Catppuccin Macchiato Blue`

## Documentation

Work in progress...

Currently all custom options are namespaced under the `modules` option.

Options are defined according to the directory structure.

To tweak options, take a look at the [modules](./modules/)

Feel free to reach out if you have any questions.
