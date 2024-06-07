# Plymouth boot animation display utility configuration
# (https://www.freedesktop.org/wiki/Software/Plymouth/)

{ config, pkgs, ... }:

{
  boot = {
    # Enable systemd in initrd
    initrd.systemd.enable = true;
    # Enable plymouth
    plymouth.enable = true;
    # Hide kernel initialization logs
    kernelParams = [ "quiet" ];
  };
  
  # TODO: Add a custom theme https://github.com/adi1090x/plymouth-themes
}
