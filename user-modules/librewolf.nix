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

    # Configure the main profile
    # See all avaliable options at:
    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.enable
    profiles.main = {
      id = 0;
      isDefault = true;
      
      # TODO: Load bookmarks from sops-encrypted json backup
      # Load the bookmarks
      #bookmarks = (builtins.fromJSON (builtins.readFile ./main-bookmarks.json));
      bookmarks = {};

      # Install extensions per profile from Nix User Repositories (NUR)
      # https://nur.nix-community.org/
      # NOTE: I did not enable NUR by default in this config
      # so follow their documentation
      # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #   ublock-origin    # Efficient wide-spectrum content blocker
      #   decentraleyes    # Local content delivery network emulation
      #   canvasblocker    # Alters JS APIs to prevent fingerprinting
      #   sponsorblock     # Skip YouTube video sponsors
      #   darkreader       # Dark mode for every website
      # ]

      # Force replace the existing containers configuration
      containersForce = true;

      # Set up tab containers
      containers = {
        Bluesky = {
          color = "blue";
          icon = "circle";
          id = 1;
        };
        Tumblr = {
          color = "pink";
          icon = "circle";
          id = 2;
        };
        ActivityPub = {
          color = "purple";
          icon = "circle";
          id = 3;
        };
        Discord = {
          color = "purple";
          icon = "circle";
          id = 4;
        };
        Matrix = {
          color = "green";
          icon = "circle";
          id = 5;
        };
        Revolt = {
          color = "red";
          icon = "circle";
          id = 6;
        };
        Git = {
          color = "yellow";
          icon = "circle";
          id = 7;
        };
        Art = {
          color = "blue";
          icon = "circle";
          id = 8;
        };
      };
    };

    # Configure the container profile
    profiles.container = {
      id = 1;

      # Load the bookmarks
      #bookmarks = (builtins.fromJSON (builtins.readFile ./container-bookmarks.json));
      bookmarks = {};

      # Configure profile settings
      settings = {
        "webgl.disabled" = false;
      };

      # Force replace the existing containers configuration
      containersForce = true;
      
      # Set up tab containers
      containers = {
        Google = {
          color = "red";
          icon = "circle";
          id = 1;
        };
        Yandex = {
          color = "yellow";
          icon = "circle";
          id = 2;
        };
        University = {
          color = "turquoise";
          icon = "circle";
          id = 3;
        };
        Services = {
          color = "blue";
          icon = "circle";
          id = 4;
        };
        Work = {
          color = "orange";
          icon = "circle";
          id = 5;
        };
      };
    };
  };
}
