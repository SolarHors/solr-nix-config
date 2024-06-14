# Configuration for enabling gaming

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXScrnSaver
    libpng
    libpulseaudio
    libvorbis
    stdenv.cc.cc.lib
    libkrb5
    keyutils
    gamescope
    mangohud
    bottles
    steam
  ];
}