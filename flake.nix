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
      url = "github:hyprwm/hyprland";
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
    # TOML configuration for the personal profile
    personal_config = (builtins.fromTOML (builtins.readFile ./user-profiles/personal/config.toml));
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
          # Profile TOML configuration settings
          inherit personal_config;
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
        };
        # User configuration
        modules = [ ./user-profiles/personal ];
      };
    };
  };
}
