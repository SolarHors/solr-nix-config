# Configuration options shared between all desktops

{ config, pkgs, ... }:

{
  # # Unify GTK3 and GTK4 application styles
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "adw-gtk3";
  #     # Package is defined by Stylix
  #     # package = pkgs.adw-gtk3;
  #   };
  # };

  # # Unify Qt and GTK applications
  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk";
  #   style.name = "adwaita-dark";
  # };
}
