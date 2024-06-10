# Network file share configuration

{ config, pkgs, ... }:

{
  # Enable Samba for SMB/CIFS protocol support
  services.samba.enable = true;
  services.samba.openFirewall = true;
  # Enable GVfs -- a userspace virtual filesystem
  services.gvfs.enable = true;
}
