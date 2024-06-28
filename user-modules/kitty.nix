# Configuration for the Kitty terminal emulator
# https://sw.kovidgoyal.net/kitty/

{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      # Manually set font
      font_family = "Iosevka NF";
      bold_font = "Iosevka NF Bold";
      italic_font = "Iosevka NF Italic";
      bold_italic_font = "Iosevka NF Bold Italic";
      # Additional configuration
      enable_audio_bell = false;
      remember_window_size = false;
      initial_window_width = 640;
      initial_window_height = 400;
      # Apply Stylix colors
      foreground = config.lib.stylix.colors.base05;
      background = config.lib.stylix.colors.base00;
    };
  };
}