# Configuration for enabling gaming

{ config, pkgs, ... }:

{
  programs = {
    steam = {
      # Enable Steam
      enable = true;
      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true;
      # Open ports in the firewall for Source Dedicated Server
      dedicatedServer.openFirewall = true;
    };
    # TODO: Add proper gamescope config
    # Enable Gamescope microcompositor
    gamescope.enable = true;
  };

  home.packages = with pkgs; [
    gamescope    # Micro-compositor tailored towards gaming
    mangohud     # Overlay for monitoring game statistics
    bottles      # An easy-to-use wineprefix manager
  ];
}
