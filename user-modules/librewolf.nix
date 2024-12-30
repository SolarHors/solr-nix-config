# Configuration for the Librewolf browser
# https://mozilla.org/firefox

{ config, lib, pkgs, ... }:

{
  # Link to generated Firefox configuration
  # TODO: Find a better workaround
  home.activation = {
    link_ff_lw_configs = lib.hm.dag.entryAfter ["writeBoundary"] ''
      run [ ! -e $HOME/.librewolf ] && ln -s $HOME/.mozilla/firefox $HOME/.librewolf
    '';
  };

  # Generate Firefox profile comfiguration
  # while installing Librewolf
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;

    # Enable Tridactyl native messaging support
    nativeMessagingHosts = [ pkgs.tridactyl-native ];

    # Configure the main profile
    # See all avaliable options at:
    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.enable
    profiles.main = {
      id = 0;
      isDefault = true;
      
      # TODO: Safely load bookmarks
      # Load the bookmarks
      # bookmarks = (builtins.fromJSON (builtins.readFile ./main-bookmarks.json));

      # Install extensions per profile from Nix User Repositories (NUR)
      # https://nur.nix-community.org/
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        tridactyl        # Vim-like interface for Firefox
        ublock-origin    # Efficient wide-spectrum content blocker
        decentraleyes    # Local content delivery network emulation
        canvasblocker    # Alters JS APIs to prevent fingerprinting
        sponsorblock     # Skip YouTube video sponsors
        darkreader       # Dark mode for every website
      ];

      # Set a minimal style inspired by qutebrowser
      # https://github.com/rockofox/firefox-minima
      userChrome = ''
        @import "${
          builtins.fetchGit {
              url = "https://github.com/rockofox/firefox-minima";
              ref = "main";
              rev = "dc40a861b24b378982c265a7769e3228ffccd45a"; # Update commit hash
          }
        }/userChrome.css";
      '';

      # Configure profile settings
      settings = {
        # Enable autoscroll
        "general.autoScroll" = true;
        # Enable user styles
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Less private, sensible overrides:
        # Disable RFP
        "privacy.resistFingerprinting" = false;
        # Enable WebGL
        "webgl.disabled" = false;
        # 
      };

      # Force replace the existing containers configuration
      containersForce = true;
      containers = {};
    };

    # Configure the container profile
    profiles.container = {
      id = 1;

      # Load the bookmarks
      # bookmarks = (builtins.fromJSON (builtins.readFile ./container-bookmarks.json));

      # Configure profile settings
      settings = {
        # Enable autoscroll
        "general.autoScroll" = true;
        # Disable RFP
        "privacy.resistFingerprinting" = false;
        # Enable WebGL
        "webgl.disabled" = false;
        # Enable user styles
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        # Save some site data
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.offlineApps" = false;
        "privacy.clearOnShutdown.sessions" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
      };

      # Force replace the existing containers configuration
      containersForce = true;
      
      # Set up tab containers
      containers = {
        Work = {
          color = "orange";
          icon = "circle";
          id = 1;
        };
      };
    };
  };

  # Create XDG desktop entries for both profiles
  xdg.desktopEntries = {
    librewolf-container = {
      name = "Librewolf (Container)";
      comment = "Secondary Librewolf profile";
      genericName = "Web Browser";
      exec = "librewolf -P container %u";
      terminal = false;
      type = "Application";
      icon = "librewolf";
      categories = [ "GNOME" "GTK" "Network" "WebBrowser" ];
      # mimeType = [ "text/html" "text/xml" "application/xhtml+xml" "application/xml" "application/rss+xml" "application/rdf+xml" "image/gif" "image/jpeg" "image/png" "x-scheme-handler/http" "x-scheme-handler/https" "x-scheme-handler/ftp" "x-scheme-handler/chrome" "video/webm" "application/x-xpinstall" ];
      startupNotify = true;
    };
    librewolf = {
      name = "Librewolf (Main)";
      comment = "Main Librewolf profile";
      genericName = "Web Browser";
      exec = "librewolf -P main %u";
      terminal = false;
      type = "Application";
      icon = "librewolf";
      categories = [ "GNOME" "GTK" "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" "application/xhtml+xml" "application/xml" "application/rss+xml" "application/rdf+xml" "image/gif" "image/jpeg" "image/png" "x-scheme-handler/http" "x-scheme-handler/https" "x-scheme-handler/ftp" "x-scheme-handler/chrome" "video/webm" "application/x-xpinstall" ];
      startupNotify = true;
    };
  };
}
