# Home environment configuration file
# It replaces `~/.config/nixpkgs/home.nix`
{
  inputs,
  lib,
  config,
  pkgs,
  personal_config,
  ...
}:

{
  imports = [
    # Load desktop configuration based on user configuration
    {
      "plasma" = ../../user-modules/desktop/plasma.nix;
      "hyprland" = ../../user-modules/desktop/hyprland.nix;
    }.${personal_config.user.desktop}
    
    # Install VSCodium
    ../../user-modules/vscodium.nix
  ];

  # Set username and homedir
  home = {
    username = personal_config.user.username;
    homeDirectory = "/home/" + personal_config.user.username;
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Install user packages
  home.packages = with pkgs; [
    alacritty                # GPU-accelerated terminal emulator
    librewolf                # Firefox fork, focused on privacy and security
    thunderbird              # Fully-featured E-mail client
    telegram-desktop         # Telegram Desktop messaging app
    webcord                  # Discord client implemented without Discord API
    blender-hip              # Blender with hardware accelerated rendering
    keepassxc                # Offline password manager
    godot_4                  # Godot 4 game engine
    krita                    # Painting application
    inkscape                 # Vector graphics editor
    transmission_4-gtk       # BitTorrent client
    onlyoffice-bin           # Office suite
    localsend                # Local file sharing between devices
    pika-backup              # Backup utility based on borg
    gvfs                     # Virtual Filesystem support library
    mpv                      # Media player
    papirus-icon-theme       # Papirus icon theme
    tealdeer                 # Simplified and community-driven man pages
    yt-dlp                   # Tool to download videos from YouTube
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
