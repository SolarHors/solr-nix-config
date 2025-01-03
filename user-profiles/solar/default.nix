# Home environment configuration file
# It replaces `~/.config/nixpkgs/home.nix`
{
  inputs,
  lib,
  config,
  pkgs,
  solar_config,
  ...
}:

{
  imports = [
    # Load desktop configuration based on user configuration
    {
      "plasma" = ../../user-modules/desktop/plasma.nix;
      "hyprland" = ../../user-modules/desktop/hyprland.nix;
      "sway" = ../../user-modules/desktop/sway.nix;
    }.${solar_config.user.desktop}

    # Configure user shell and console-line tools
    ../../user-modules/shell.nix

    # Add gaming configuration with Steam
    ../../user-modules/games.nix

    # Configure VSCodium
    ../../user-modules/vscodium.nix

    # Configure Kitty terminal emulator
    ../../user-modules/kitty.nix

    # Enable a Discord client
    ../../user-modules/discord.nix

    # Configure Librewolf
    ../../user-modules/librewolf.nix

    # Theme user applications
    ../../user-modules/stylix.nix
  ];

  # Set username and homedir
  home = {
    username = solar_config.user.username;
    homeDirectory = "/home/" + solar_config.user.username;
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Allow unfree software with home-manager
  nixpkgs.config.allowUnfree = true;

  # Install user packages
  home.packages = with pkgs; [
    tor-browser              # Hardened browser utilizing the Tor network
    thunderbird              # Fully-featured E-mail client
    telegram-desktop         # Telegram Desktop messaging app
    iamb                     # Matrix chat client in the terminal
    blender-hip              # Blender with hardware accelerated rendering
    keepassxc                # Offline password manager
    godot_4                  # Godot 4 game engine
    krita                    # Painting application
    inkscape                 # Vector graphics editor
    qbittorrent              # BitTorrent client
    onlyoffice-bin           # Office suite
    (lowPrio localsend)      # Local file sharing between devices
    pika-backup              # Backup utility based on borg
    ffmpeg                   # A solution to manipulate audio and video
    mpv                      # Media player
    amberol                  # A simple music player
    papirus-icon-theme       # Papirus icon theme
    tealdeer                 # Simplified and community-driven man pages
    yt-dlp                   # Tool to download videos from YouTube
    via                      # Keyboard configuration utility
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
