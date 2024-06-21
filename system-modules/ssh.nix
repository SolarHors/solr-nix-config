# SSH configuration for incoming connections

{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Enable GnuPG support
  if programs.gnupg.agent.enable
  then programs.gnupg.agent.enableSSHSupport = true;

  environment.systemPackages = with pkgs; [
    openssh    # An implementation of the SSH protocol
  ]
}
