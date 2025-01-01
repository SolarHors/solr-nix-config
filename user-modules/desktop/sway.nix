# Sway tiling Wayland compositor user configuration
# (https://swaywm.org/)

{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    # Use system package instead
    package = null;

    config = {
      # Modifier key set to Super
      modifier = "Mod4";

      # TODO: Figure out monitor configuration
      # Output configuration:
      output = {
        "HDMI-A-1" = {
          mode = "1920x1080@60.000Hz";
          position = "0,0";
        };
        "DP-3" = {
          mode = "1920x1080@60.000Hz";
          position = "1920,0";
        };
      };

      # Input configuration:
      input = {
        "13364:560:Keychron_Keychron_K3_Pro" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:lalt_lshift_toggle";
        };
        "2522:63211:COMPANY_USB_Device" = {
          accel_profile = "flat";
          pointer_accel = "+0.5";
        };
      };

      # Display swaybar at the top of the screen
      bars = [{
        position = "top";
        statusCommand = "${pkgs.i3status}/bin/i3status";
      }];
    };
  };
}
