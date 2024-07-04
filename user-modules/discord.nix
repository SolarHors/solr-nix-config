# Set up a Discord client with arRPC -- an open
# implementation of Discord's local RPC servers
# (https://arrpc.openasar.dev/)

{ config, pkgs, ... }:

{
  # Install a Discord client
  home.packages = with pkgs; [
    #webcord                  # Discord client implemented without Discord API
    vesktop                  # Client for Discord with Vencord built-in
  ];

  # Check this link to use arRPC in Webcord
  # https://github.com/OpenAsar/arrpc?tab=readme-ov-file#webcord

  # Enable arRPC
  services.arrpc.enable = true;
}
