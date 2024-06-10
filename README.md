# Solr's silly NixOS configuration

> [!CAUTION]
> This configuration is not finished and may break (or is already broken). I am in the process of writing and testing it.

> [!NOTE]
> I am still very new to NixOS, there are likely to be many irrational and inefficient configuration solutions in this repository.

This is my personal NixOS and Home Manager configuration using [flakes](https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html). Feel free to use it as is or as a reference. While writing this configuration I did my best to understand how and why it functions and leave explanatory comments. A list of configurations made by other people that I learned from is presented [below](#References).

## TODO

- [ ] Figure out how Cachix for Hyprland works or remove it
- [ ] Declarative flatpak configuration (focusing on user applications)
- [ ] Use adw-gtk3 for GTK3 apps
- [ ] Move libvirtd user group assignment into virt.nix
- [ ] Possibly remove Stylix from specialArgs and use inputs
- [ ] Nvim configuration
- [ ] Presentable Hyprland configuration
- [ ] Custom SDDM theme in Hyprland
- [ ] Leave only necessary imports in derivations
- [ ] TOML configuration for basic system profile features (like encryption, vpn)
- [ ] ~~Write a GNOME config (for completeness' sake)~~
- [ ] ~~Set stylix.targets.gnome.enable in GNOME config~~
- [x] TOML configuration for basic user profile features
- [x] Uniform system styling using [Stylix](https://github.com/danth/stylix)
- [x] Minimal usable configuration for KDE Plasma

## Structure

To be added.

## Installation

To be added.

## References

Thanks to the people below for writing informative and (mostly) comprehensive configurations:
- [librephoenix/nixos-config](https://gitlab.com/librephoenix/nixos-config/)
- [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
