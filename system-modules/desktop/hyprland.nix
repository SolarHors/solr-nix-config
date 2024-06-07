# Hyprland dynamic tiling Wayland compositor configuration
# (https://hyprland.org/)

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Install additional packages
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland     # Hyprland portal
    sddm-chili-theme                # SDDM theme
  ];

  # Add Hyprland portal to path
  xdg.portal.extraPortals = with pkgs; [
    # xdg-desktop-portal-hyprland
  ];

  services.xserver = {
    # Configure display manager
    displayManager = {
      sddm = {
        # Enable Simple Desktop Display Manager
        enable = true;
        # Enable experimental Wayland support
        wayland.enable = true;
        # Set SDDM theme
        theme = "chili";
      };
      # Select Hyprland session by default
      defaultSession = "hyprland";
    };
  };

  # Enable Hyprland Cachix
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    # Enable Hyprland
    enable = true;
    # Enable XWayland support
    xwayland.enable = true;
    # Use development version defined in `flake.nix`
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
}
