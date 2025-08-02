{
  description = "Multi-Host NixOS configuration";

  inputs = {
    # Using the unstable channel for nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager,... }@inputs:
  let
    system = "x86_64-linux";
    user = "clement";
    lib = nixpkgs.lib;

    # Hosts definition (with nixos-unstable)
    hosts = [
      { 
      hostname = "orion"; stateVersion = "unstable"; bundles = { 
        hyprland = true;
	app = true;
	dev = true;
	terminal = true;
        };
      }
    ];

    makeSystem = { hostname, stateVersion, bundles }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs hostname stateVersion user bundles;
      };
      modules = lib.flatten [
        ./hosts/${hostname}/configuration.nix
	./modules/nixos/default.nix
        (lib.optional bundles.hyprland ./modules/nixos/hyprland/bundle.nix)
        (lib.optional bundles.app ./modules/nixos/app/bundle.nix)
        (lib.optional bundles.dev ./modules/nixos/dev/bundle.nix)
        (lib.optional bundles.terminal ./modules/nixos/terminal/bundle.nix)
	home-manager.nixosModules.home-manager
        {
	  home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = {inherit user;};
	  home-manager.users.${user} = import ./hosts/${hostname}/home.nix;
        }
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

