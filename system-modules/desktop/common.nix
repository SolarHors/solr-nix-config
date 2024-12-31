# Configuration options shared between all desktops

{ config, pkgs, ... }:

{
  # Enable OpenGL drivers
  hardware.opengl.enable = true;
  # Enable RealtimeKit system service
  security.rtkit.enable = true;

  services = {
    xserver = {
      # Enable XWayland
      enable = true;
      # Set X keyboard layout
      xkb.layout = "us,ru";
      # Set X keyboard variant
      xkb.variant = "";
    };
    # Interprocess messaging system
    dbus = {
      enable = true;
      # Include dconf's config in D-Bus
      packages = [ pkgs.dconf ];
    };
    # API to deal with multimedia pipelines
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # Touchpad support
    libinput.enable = true;
  };

  # Enable dconf settings management tool
  programs.dconf.enable = true;

  # Enable desktop portals
  xdg.portal = {
    enable = true;
    # Make xdg-open use the portal to open programs
    xdgOpenUsePortal = true;
  };

  # Install additional packages
  environment.systemPackages = with pkgs; [
    pkgs.wayland                    # Core Wayland window system code
    qt6.qtwayland                   # Qt6 Wayland support
    libsForQt5.qt5.qtwayland        # Qt5 Wayland support
  ];

  # Set Wayland-specific environment variables:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  environment.sessionVariables.QT_QPA_PLATFORM = "wayland";
  environment.sessionVariables.SDL_VIDEODRIVER = "wayland";
  environment.sessionVariables.ELM_DISPLAY = "wl";
  environment.sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";
}
