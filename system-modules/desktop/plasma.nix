# KDE Plasma desktop environment system configuration
# (https://kde.org/plasma-desktop/)

{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Install KDE portal for Qt5 applications
  environment.systemPackages = with pkgs; [
    libsForQt5.xdg-desktop-portal-kde
  ];

  # Add KDE Qt5 portal
  xdg.portal.extraPortals = with pkgs; [
    libsForQt5.xdg-desktop-portal-kde
  ];

  services.xserver = {
    # Enable KDE Plasma 6
    desktopManager.plasma6.enable = true;
    # Configure display manager
    displayManager = {
      sddm = {
        # Enable SDDM display manager
        enable =  true;
        # Enable experimental Wayland support
        wayland.enable = true;
      };
      # Select Plasma-Wayland session by default
      #defaultSession = "plasmawayland";
    };
  };

  # Exclude Plasma packages
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    khelpcenter
    plasma-browser-integration
  ];
}
