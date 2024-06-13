{
  description = "Solar's silly NixOS config!";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # System-wide colorscheming and typography for NixOS
    stylix.url = "github:danth/stylix";

    # Manage user environments with Nix using Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix overlay for Rust toolchains
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland window manager
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland plugins
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hardware,
    stylix,
    rust-overlay,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # TOML configuration for the system profile of `orange-desktop`
    orange_config = (builtins.fromTOML (builtins.readFile ./system-profiles/orange-desktop/config.toml));
    # TOML configuration for the user profile of `solar`
    solar_config = (builtins.fromTOML (builtins.readFile ./user-profiles/solar/config.toml));
  in {
    # NixOS system configuration entrypoint
    # Available through `nixos-rebuild --flake .#HOSTNAME`
    nixosConfigurations = {
      # Desktop
      "orange-desktop" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          # Style system-wide applications
          inherit (inputs) stylix;
          # System profile TOML configuration settings
          inherit orange_config;
          # User profile TOML configuration settings
          inherit solar_config;
        };
        # System configuration
        modules = [ ./system-profiles/orange-desktop ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through `home-manager --flake .#USERNAME@HOSTNAME`
    # NOTE: orange-desktop uses home-manager as a module,
    # meaning user-wide configuration is applied during rebuild
    homeConfigurations = {
      "solar@orange-desktop" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires `pkgs` instance
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
          # Style user-wide applications
          inherit (inputs) stylix;
          # User profile TOML configuration settings
          inherit solar_config;
        };
        # User configuration
        modules = [ ./user-profiles/solar ];
      };
    };
  };
}
