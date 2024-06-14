# Stylix user-wide colorscheming and typography module configuration
# While the system Stylix configuration is inherited, some additional
# software styling can be enabled or overridden
# (https://github.com/danth/stylix)

{ config, pkgs, ... }:

{
  stylix = {
    # Theme most user programs
    autoEnable = true;

    # Explicitly theme programs
    # targets = {
    #   alacritty.enable = true;
    #   bat.enable = true;
    #   firefox.enable = true;
    #   helix.enable = true;
    #   mangohud.enable = true;
    #   vscode.enable = true;
    #   fzf.enable = true;
    #   gtk.enable = true;
    #   hyprland.enable = true;
    #   kde.enable = true;
    # };
  };
}
