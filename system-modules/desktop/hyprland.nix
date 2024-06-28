# Hyprland dynamic tiling Wayland compositor configuration
# (https://hyprland.org/)

{ config, pkgs, inputs, orange_config, solar_config, ... }:

{
  imports = [
    ./common.nix
  ];

  # Install additional packages
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland    # Hyprland portal
    greetd.tuigreet                # Graphical console greeter
  ];

  # Add Hyprland portal to path
  # xdg.portal.extraPortals = with pkgs; [
  #   xdg-desktop-portal-hyprland
  # ];

  # Enable Hyprland Cachix
  # nix.settings = {
  #   substituters = [ "https://hyprland.cachix.org" ];
  #   trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  # };

  services = {
    # Autologin user if drive encryption is enabled
    autoLogin.enable = 
      if orange_config.hardware.cryptroot_uuid == ""
      then false
      else true;
    autoLogin.user = solar_config.user.username;
    # Greetd login manager
    greetd = let
      tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
      hyprland-session = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/wayland-sessions";
    in {
      enable = true;
      settings = {
        default_session = {
          command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session}";
          user = "greeter";
        };
      };
    };
  };

  # Referenced from sjcobb2022/nixos-config
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    # Hide errors on login screen
    StandardError = "journal";
    # Hide bootlogs on login screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
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
