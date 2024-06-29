# KDE Plasma desktop environment user configuration
# (https://kde.org/plasma-desktop/)

{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # If required, KDE Plasma can be further managed using
  # https://github.com/pjones/plasma-manager
  
  # Enable configuration for Qt 4, 5 and 6
  # qt.enable = true;
}
