# Configuration for the Kitty terminal emulator
# https://sw.kovidgoyal.net/kitty/

{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      # Manually set font to Nerd Font version
      font_family = "FiraCode Nerd Font";
      bold_font = "FiraCode Nerd Font Bold";
      # Activate font features
      # https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets
      font_features = "FiraCodeNF-Reg +zero +cv06";
      # Additional configuration
      enable_audio_bell = false;
      remember_window_size = false;
      initial_window_width = 800;
      initial_window_height = 500;
      # Style tab bar
      # TODO: Style Kitty tab bar
    };
  };
}