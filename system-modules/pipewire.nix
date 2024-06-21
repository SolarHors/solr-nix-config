# Pipewire - low-latency, graph-based processing
# engine on top of audio and video devices
# (https://www.pipewire.org/)

{ config, pkgs, ... }:

{
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
