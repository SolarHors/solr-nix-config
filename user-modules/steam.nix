# Steam video game digital distribution service configuration
# (https://store.steampowered.com/)

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
    # Enable Gamescope microcompositor
    gamescope.enable = true;
  };
}
