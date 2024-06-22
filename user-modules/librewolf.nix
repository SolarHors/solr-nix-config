# Configuration for the Librewolf browser
# https://librewolf.net/

{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    # Install a Firefox fork, focused on privacy and security
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

      # Install extensions from Nix User Repositories (NUR)
      # https://nur.nix-community.org/
      # NOTE: I did not enable NUR by default in this config
      # so follow their documentation
      # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #   ublock-origin
      #   sponsorblock
      #   darkreader
      # ]

      # Force replace the existing containers configuration
      containersForce = true;

      # Set up tab containers
      containers = {
        bluesky = {
          color = "blue";
          icon = "circle";
          id = 1;
        };
        tumblr = {
          color = "pink";
          icon = "circle";
          id = 2;
        };
        activitypub = {
          color = "purple";
          icon = "circle";
          id = 3;
        };
        discord = {
          color = "purple";
          icon = "circle";
          id = 4;
        };
        matrix = {
          color = "green";
          icon = "circle";
          id = 5;
        };
        revolt = {
          color = "red";
          icon = "circle";
          id = 6;
        };
        git = {
          color = "yellow";
          icon = "circle";
          id = 7;
        };
        derpi = {
          color = "blue";
          icon = "circle";
          id = 8;
        };
      };
    };

    # Configure the container profile
    profiles.container = {
      id = 1;

      # Adjust browser settings
      settings = {
        # Enable WebGL in this profile
        "webgl.disabled" = false;
      };

      # Load the bookmarks
      #bookmarks = (builtins.fromJSON (builtins.readFile ./container-bookmarks.json));

      # Force replace the existing containers configuration
      containersForce = true;
      
      # Set up tab containers
      containers = {
        google = {
          color = "red";
          icon = "circle";
          id = 1;
        };
        yandex = {
          color = "yellow";
          icon = "circle";
          id = 2;
        };
        university = {
          color = "turquoise";
          icon = "circle";
          id = 3;
        };
        services = {
          color = "blue";
          icon = "circle";
          id = 4;
        };
        work = {
          color = "orange";
          icon = "circle";
          id = 5;
        };
      };
    };
  };
}
