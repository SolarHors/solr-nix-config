# Configuration for enabling gaming

{ config, pkgs, ... }:

{
  programs = {
    steam = {
      # Enable Steam digital distribution platform
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
}
