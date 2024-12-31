# Sway tiling Wayland compositor configuration
# (https://swaywm.org/)

{ config, pkgs, inputs, orange_config, solar_config, ... }:

let
  # Prepare dbus session variables. Run at the end of sway config.
  # See this link for more information:
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/%22It-doesn't-work%22-Troubleshooting-Checklist
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user restart pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
in
{
  imports = [
    ./common.nix
  ];

  # Configure XDG portal specifics
  xdg.portal = {
    # Enable desktop portal for wlroots-based desktops
    wlr.enable = true;
    # Add GTK portal to path
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services = {
    # Configure display manager
    displayManager = {
      # sddm.enable = lib.mkForce false;
      # ly.enable = true;
      # ly.settings = {
      #   animation = "matrix";
      #   clear_password = true;
      #   initial_info_text = "Only solrbutts allowed~!";
      # };
      # Autologin user if drive encryption is enabled
      autoLogin.enable = 
        if orange_config.hardware.cryptroot_uuid == ""
        then false
        else true;
      autoLogin.user = solar_config.user.username;
    };
  };

  # Install additional packages
  environment.systemPackages = with pkgs; [
    grim             # Grab images from a Wayland compositor
    slurp            # Select a region in a Wayland compositor
    wf-recorder      # Screen recording from a Wayland compositor
    wl-clipboard      # Command-line copy/paste utilities
    mako             # Wayland notification daemon
    tofi             # Dynamic menu
    wlsunset         # Day/night gamma adjustments
    autotiling-rs    # Automatically switch window split orientation
    swaylock         # Screen locker
    swayidle         # Idle management daemon
  ];

  programs.sway = {
    enable = true;
    xwayland.enable = true;
    wrapperFeatures.gtk = true;
  };
}
