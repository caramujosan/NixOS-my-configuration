{
	description = "NixOS configuration with Flakes and Home Manager";

	inputs = {
	  # Official NixOS repository (unstable channel, or switch to nixos-26.05)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
	  nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

	  # Repositorio do Home Manager
	  home-manager = {
	    url = "github:nix-community/home-manager/release-26.05";
	    # Ensures that Home Manager uses the same nixpkgs version as the system
	    inputs.nixpkgs.follows = "nixpkgs";
	  };
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: {
	  nixosConfigurations = {
	    nixos = nixpkgs.lib.nixosSystem {
	      system = "x86_64-linux";
		    modules = [
		      ./hardware-configuration.nix
		      ./configuration.nix

	   	    # Home Manager Module Integration
		      home-manager.nixosModules.home-manager {
		        home-manager.useGlobalPkgs = true;
		        home-manager.useUserPackages = true;

  	        # Maps the settings to your specific user
	          home-manager.users.caramujosan = import ./home.nix;

		        # Optional: pass extra arguments (such as inputs) to home.nix if necessary
		        # home-manager.extraSpecialArgs = { inherit inputs; };
		      }
		    ];
	    };
	  };
	};
}
