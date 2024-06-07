# KDE Plasma desktop environment system configuration
# (https://kde.org/plasma-desktop/)

{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Install KDE portal
  environment.systemPackages = with pkgs; [
    libsForQt5.xdg-desktop-portal-kde
  ];

  # Add KDE portal to path
  xdg.portal.extraPortals = with pkgs; [
    libsForQt5.xdg-desktop-portal-kde
  ];

  services.xserver = {
    # Enable KDE Plasma 5
    desktopManager.plasma5.enable = true;
    # Configure display manager
    displayManager = {
      sddm = {
        # Enable SDDM display manager
        enable =  true;
        # Enable experimental Wayland support
        wayland.enable = true;
      };
      # Select Plasma-Wayland session by default
      defaultSession = "plasmawayland";
    };
  };

  # Exclude Plasma packages
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    konsole
    khelpcenter
    plasma-browser-integration
  ];
}
