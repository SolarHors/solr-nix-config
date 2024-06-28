# Configuration for enabling gaming

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gamescope         # Micro-compositor tailored towards gaming
    mangohud          # Overlay for monitoring game statistics
    bottles           # An easy-to-use wineprefix manager
    steam             # Digital distribution platform
    prismlauncher     # Launcher for Minecraft
    # Compatibility packages (probably) required by Steam
    libpulseaudio
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXScrnSaver
    # Java 17 is required by some minecraft versions
    jdk17
  ];
}