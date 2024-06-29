# Configuration options shared between all desktops

{ config, pkgs, ... }:

{
  # Unift GTK3 and GTK4 application styles
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };

  # Unify Qt and GTK applications
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "adwaita-dark";
  };
}
