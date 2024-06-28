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

  # Enable GnuPG support if GnuPG is enabled
  programs.gnupg.agent.enableSSHSupport = 
    config.programs.gnupg.agent.enable;

  environment.systemPackages = with pkgs; [
    openssh    # An implementation of the SSH protocol
  ];
}
