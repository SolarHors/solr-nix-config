# Configuration options shared between all desktops

{ config, pkgs, ... }:

{
  # Enable OpenGL drivers
  hardware.opengl.enable = true;

  services = {
    xserver = {
      # Enable XWayland
      enable = true;
      # Set X keyboard layout
      xkb.layout = "us,ru";
      # Set X keyboard variant
      xkb.variant = "";
    };
    dbus = {
      # Enable D-Bus
      enable = true;
      # Include dconf's config in D-Bus
      packages = [ pkgs.dconf ];
    };
    # Touchpad support
    libinput.enable = true;  
  };

  # Enable dconf settings management tool
  programs.dconf.enable = true;

  # Configure desktop portal for wlroots-based desktops
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ];
  };

  # Install additional packages
  environment.systemPackages = with pkgs; [
    pkgs.wayland                    # Core Wayland window system code
    qt6.qtwayland                   # Qt6 Wayland support
    libsForQt5.qt5.qtwayland        # Qt5 Wayland support
  ];

  # Hint electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
