# Stylix system-wide colorscheming and typography module configuration
# While using home-manager as a module, it will inherit
# system Stylix configuration
# (https://github.com/danth/stylix)

{ config, pkgs, stylix, personal_config, ... }:

{
  imports = [
    # Stylix module for system-wide configuration
    stylix.nixosModules.stylix
  ];

  # Set the wallpaper
  stylix.image = pkgs.fetchurl {
    url = personal_config.theme.bg_url;
    sha256 = personal_config.theme.bg_sha256;
  };
  
  # Use light / dark theme or either if value is not set
  stylix.polarity = let
    theme = personal_config.theme.polarity;
    in if theme != "dark" && theme != "light"
      then "either"
      else theme;
  
  # Set color scheme
  # TODO: Allow deriving from wallpaper by leaving value empty
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/" + personal_config.theme.colors + ".yaml";

  # Set default fonts
  stylix.fonts = {
    serif = {
      package = pkgs.merriweather;
      name = "Merriweather";
    };

    sansSerif = {
      package = pkgs.merriweather-sans;
      name = "Merriweather Sans";
    };

    monospace = {
      package = pkgs.fira-code;
      name = "Fira Code";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
}