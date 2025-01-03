# System environment configuration file
# It replaces `/etc/nixos/configuration.nix`
# Help is available in the configuration.nix(5) man page
{
  inputs,
  outputs,
  pkgs,
  orange_config,
  solar_config,
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

    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
    
    # Select desktop based on user configuration
    {
      "plasma" = ../../system-modules/desktop/plasma.nix;
      "sway" = ../../system-modules/desktop/sway.nix;
      "hyprland" = ../../system-modules/desktop/hyprland.nix;
    }.${solar_config.user.desktop}

    # Enable SSH and GnuPG
    ../../system-modules/ssh.nix
    ../../system-modules/gpg.nix

    # Enable Open Tablet Driver
    # ../../system-modules/otd.nix

    # Install font packages
    ../../system-modules/fonts.nix

    # Configure network shares
    ../../system-modules/netshare.nix

    # Enable Wireguard VPN
    ../../system-modules/vpn.nix

    # Enable virtualization
    ../../system-modules/virtualization.nix

    # Theme system applications
    ../../system-modules/stylix.nix
  ];

  # Home-manager module configuration entrypoint
  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
      # Profile TOML configuration settings
      inherit solar_config;
    };
    # Overwrite config after backing it up
    backupFileExtension = "backup";
    # Use the system configuration’s pkgs argument
    useGlobalPkgs = true;
    # Import home-manager configurations for users
    users.${solar_config.user.username} = import ../../user-profiles/solar;
  };

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
    # Users allowed to connect to the Nix daemon
    allowed-users = [ "@wheel" ];
  };

  # Configure boot options
  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];
    initrd.kernelModules = [ "amdgpu" ];
    initrd.systemd.dbus.enable = true;

    # Unlock encrypted root device (if present)
    initrd.luks.devices = 
      if orange_config.hardware.cryptroot_uuid == ""
      then {}
      else {
        root = {
          device = "/dev/disk/by-uuid/${orange_config.hardware.cryptroot_uuid}";
          preLVM = true;
          allowDiscards = true;  # SSD optimizations
        };
      };
  };

  # Add secondary storage drive to fstab
  fileSystems."/media/storage" = if orange_config.hardware.cryptstorage_uuid == ""
  then {}
  else {
    device = "/dev/mapper/cryptstorage";
    fsType = "btrfs";
    options = ["defaults" "noatime" "compress=zstd"];
  };

  # Unlock secondary storage drive after boot
  environment.etc.crypttab.text = 
  if orange_config.hardware.cryptstorage_uuid == ""
  then ""
  else ''
    cryptstorage UUID=${orange_config.hardware.cryptstorage_uuid} /etc/storage.key luks
  '';

  # Hardware configuration for AMD
  hardware = {
    # Update the CPU microcode
    cpu.amd.updateMicrocode = true;
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
        driversi686Linux.amdvlk     # 32-bit support
      ];
    };
  };

  # Set time zone
  time.timeZone = orange_config.system.timezone;
  # Select internationalization properties
  i18n = {
    defaultLocale = orange_config.system.default_locale;
    extraLocaleSettings = let
      locale = orange_config.system.additional_locale;
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
    hostName = orange_config.system.hostname;
    networkmanager.enable = true;
    nftables.enable = true;
    firewall.enable = true;
    nat.enable = true;

    hosts = {
      "127.0.0.1" = ["localhost"];
    };
  };

  # Configure system-wide user settings
  users.users.${solar_config.user.username} = {
    description = solar_config.user.description;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List system-wide packages
  environment.systemPackages = with pkgs; [
    pciutils                        # Tools for inspecting PCI device configs
    wget                            # Tool for retrieving remote files
    curl                            # Tool for transferring files with URL syntax
    git                             # Distributed version control system
    libwacom                        # Libraries and configurations for Wacom tablets
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
