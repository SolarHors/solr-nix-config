# System environment configuration file
# It replaces `/etc/nixos/configuration.nix`
# Help is available in the configuration.nix(5) man page
{
  inputs,
  outputs,
  pkgs,
  personal_config,
  ...
}:

{
  imports = [
    # Import the generated hardware configuration
    ./hardware-configuration.nix

    # Use profiles from nixos-hardware for optimal settings
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    # Import the generated hardware configuration
    ./hardware-configuration.nix

    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
    
    # Select desktop based on user configuration
    {
      "plasma" = ../../system-modules/desktop/plasma.nix;
      "hyprland" = ../../system-modules/desktop/hyprland.nix;
    }.${personal_config.user.desktop}

    # Enable sound
    ../../system-modules/pipewire.nix

    # Enable Open Tablet Driver
    ../../system-modules/otd.nix

    # Install font packages
    ../../system-modules/fonts.nix

    # Configure network shares
    ../../system-modules/netshare.nix

    # Theme system applications
    ../../system-modules/stylix.nix
  ];

  # Home-manager module configuration entrypoint
  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
      # Profile TOML configuration settings
      inherit personal_config;
    };
    # Overwrite config after backing it up
    backupFileExtension = "backup";
    # Import home-manager configurations for users
    users.${personal_config.user.username} = import ../../user-profiles/personal;
  };

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  # Configure boot options
  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];
    initrd.kernelModules = [ "amdgpu" ];

    # TODO: Make encryption more convenient to configure
    # Unlock encrypted root device
    initrd.luks.devices = {
      root = {
        # ATTENTION! Set this to the UUID of the partition
        # that contains the encrypted LUKS root
        device = "/dev/disk/by-uuid/<root-uuid>";
        preLVM = true;
        allowDiscards = true;  # SSD optimizations
      };
    };
  };

  # Hardware configuration for AMD
  hardware = {
    opengl = {
      # Enable OpenGL
      enable = true;
      # radv: an open-source Vulkan driver from freedesktop
      driSupport = true;
      driSupport32Bit = true;
      # amdvlk: an open-source Vulkan driver from AMD
      extraPackages = with pkgs; [
        amdvlk                      # AMD Open Source Driver For Vulkan
        rocmPackages.clr            # AMD Common Language Runtime
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };

  # Set time zone
  time.timeZone = "Europe/Moscow";
  # Select internationalization properties
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = let
      locale = "ru_RU.UTF-8";
    in {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };

  # Configure networking
  networking = {
    hostName = "orange-desktop";
    networkmanager.enable = true;
  };

  # Configure system-wide user settings
  users.users.${personal_config.user.username} = {
    description = personal_config.user.description;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List system-wide packages
  environment.systemPackages = with pkgs; [
    pciutils                        # Tools for inspecting PCI device configs
    ffmpeg                          # A solution to manipulate audio and video
    wget                            # Tool for retrieving remote files
    curl                            # Tool for transferring files with URL syntax
    git                             # Distributed version control system
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
