# Stylix user-wide colorscheming and typography module configuration
# While the system Stylix configuration is inherited, some additional
# software styling can be enabled or overridden
# (https://github.com/danth/stylix)

{ config, pkgs, ... }:

{
  # Theme most user programs
  stylix.autoEnable = true;
}
