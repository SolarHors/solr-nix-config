# Hyprland dynamic tiling Wayland compositor user configuration
# (https://hyprland.org/)

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./common.nix
  ];

  wayland.windowManager.hyprland = {
    # Enable Hyprland home-manager module
    enable = true;
    # Add plugins
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      # ...
    ];
    # Configure Hyprland
    settings = {
      "$mod" = "SUPER";
    };
  };
}
