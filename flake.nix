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
	./modules/default.nix
        (lib.optional bundles.hyprland ./modules/hyprland/bundle.nix)
        (lib.optional bundles.app ./modules/app/bundle.nix)
        (lib.optional bundles.dev ./modules/dev/bundle.nix)
        (lib.optional bundles.terminal ./modules/terminal/bundle.nix)
      ];
    };

    makeHome = { hostname, stateVersion, bundles }: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      specialArgs = {
        inherit inputs hostname stateVersion user bundles;
      };
      modules = lib.flatten [
        ./hosts/${hostname}/home.nix
        ./home-manager/default.nix
        # (lib.optional bundles.hyprland ./modules/hyprland/bundle.nix)
        # (lib.optional bundles.app ./modules/app/bundle.nix)
        # (lib.optional bundles.dev ./modules/dev/bundle.nix)
        # (lib.optional bundles.terminal ./modules/terminal/bundle.nix)
      ];
      home = {
        username = user;
	homeDirectory = "/home/${user}";
      };
    };
  in {
    # Define NixOS configurations for each host
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion bundles;
        };
      }) {} hosts;
    homeConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${user}" = makeHome {
          inherit (host) hostname stateVersion bundles;
        };
      }) {} hosts;
  };
}

