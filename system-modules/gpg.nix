# GNU Privacy Guard configuration

{ config, pkgs, ... }:

{
  # Enables GnuPG agent with socket-activation
  # for every user session
  programs.gnupg.agent.enable = true;

  environment.systemPackages = with pkgs; [
    gnupg    # Modern release of GnuPG
  ]
}
