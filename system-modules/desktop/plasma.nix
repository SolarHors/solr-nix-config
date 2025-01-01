# KDE Plasma desktop environment system configuration
# (https://kde.org/plasma-desktop/)

{ config, pkgs, orange_config, solar_config, ... }:

{
  imports = [
    ./common.nix
  ];

  # Add KDE Qt5 portal
  xdg.portal.extraPortals = with pkgs; [
    libsForQt5.xdg-desktop-portal-kde
  ];

  services = {
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
      # Autologin user if drive encryption is enabled
      autoLogin.enable = 
        if orange_config.hardware.cryptroot_uuid == ""
        then false
        else true;
      autoLogin.user = solar_config.user.username;
    };
  };

  # Exclude Plasma packages
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    kate
    elisa
    okular
    khelpcenter
    plasma-browser-integration
  ];
}
