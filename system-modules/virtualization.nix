# Configure virtualization options with QEMU/KVM using virt-manager

{ config, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
