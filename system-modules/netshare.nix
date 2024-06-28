# Network file share configuration

{ config, pkgs, ... }:

{
  # Enable Samba for SMB/CIFS protocol support
  services.samba.enable = true;
  services.samba.openFirewall = true;

  # Enable GVfs -- a userspace virtual filesystem
  services.gvfs.enable = true;

  # Enable Avahi service discovery facilities
  services.avahi = {
    enable = true;
    # mDNS Name Service Switch for name resolution in .local domain
    nssmdns4 = true;
    # Allow publishing
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };
}
