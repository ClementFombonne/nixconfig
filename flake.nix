{
  description = "Multi-Host NixOS configuration";

  inputs = {
    # Using the unstable channel for nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    user = "clement";
    lib = nixpkgs.lib;

    # Hosts definition (with nixos-unstable)
    hosts = [
      { 
      hostname = "orion"; stateVersion = "unstable"; bundles = { 
        hyprland = true;
	terminal = true;
        };
      }
    ];

    makeSystem = { hostname, stateVersion, bundles }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs stateVersion hostname user bundles;
      };

      modules = [
        ./hosts/${hostname}/configuration.nix
	./modules/default.nix
	(lib.optional bundles.hyprland ./modules/hyprland/bundle.nix)
	(lib.optional bundles.terminal ./modules/terminal/bundle.nix)
      ];
    };
  in {
    # Define NixOS configurations for each host
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion bundles;
        };
      }) {} hosts;
  };
}

