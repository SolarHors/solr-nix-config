{
  description = "Solr's silly NixOS config!";

  inputs = {
    # Official NixOS package source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ...} @ inputs: {
    nixosConfigurations.orange = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Configuration modules
      ];
    };
  };
}
