# Mullvad VPN configuration using Wireguard (wg-quick)
# Referenced from this guide:
# https://alberand.com/nixos-wireguard-vpn.html

{ config, pkgs, ... }:

# Do not include Mullvad configuration files into
# the Nix config as it contains private data!
# Move the value of `[Interface] > PrivateKey`
# from the downloaded Mullvad config file into a
# separate file, placed at `/etc/mullvad-vpn.key`
# Make file readable only by root:
# sudo chmod 400 /etc/aaa-bbb-wg-000.toml

# Check the guide above for killswitch setup instructions

let
  # Path to the private key file
  private_key_file = "/etc/mullvad-vpn.key";
  # [Interface] > Address
  address = [ "10.71.161.56/32" "fc00:bbbb:bbbb:bb01::8:a137/128" ];
  # [Interface] > DNS
  dns = [ "100.64.0.7" ];
  # [Peer] > PublicKey
  public_key = "8BbP3GS01dGkN5ENk1Rgedxfd80friyVOABrdMgD3EY=";
  # [Peer] > AllowedIPs
  allowed_ips = [ "0.0.0.0/0" "::/0" ];
  # [Peer] > Endpoint
  endpoint_ip = "185.204.1.211";
  endpoint_port = "51820";
in {
  # Open ports
  networking.firewall = {
    # Clients and peers can use the same port, see listenport
    allowedUDPPorts = [ endpoint_port ];
  };

  # Configure Wireguard interfaces
  networking.wg-quick.interfaces = {
    # "wg0" is the network interface name
    wg0 = {
      address = address;
      dns = dns;
      
      # To match firewall allowedUDPPorts (without this wg
      # uses random port numbers)
      listenPort = endpoint_port;
      
      # Path to the private key file
      privateKeyFile = private_key_file;
      
      peers = [
        {
          # Public key of the server
          publicKey = public_key;
          # Forward all the traffic via VPN
          allowedIPs = allowed_ips;
          # Server IP and port
          endpoint = "${endpoint_ip}:${endpoint_port}";
          # Send keepalives every 25 seconds, it is
          # mportant to keep NAT tables alive
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
