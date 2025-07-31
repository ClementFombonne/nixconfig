{
  description = "Multi-Host NixOS configuration";

  inputs = {
    # Using the unstable channel for nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: let
    system = "x86_64-linux";
    user = "clement";

    # Hosts definition (with nixos-unstable)
    hosts = [
      { hostname = "orion"; stateVersion = "unstable"; }
    ];

    makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs stateVersion hostname user;
      };

      modules = [
        ./hosts/${hostname}/configuration.nix
	./modules/default.nix
      ];
    };

  in {
    # Define NixOS configurations for each host
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion;
        };
      }) {} hosts;
  };
}

