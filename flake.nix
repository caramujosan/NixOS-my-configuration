{
  description = "NixOS configuration using Flakes and Home Manager";

  inputs = {
    # Official NixOS repository (unstable channel)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager repository
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }@inputs:
    let
      # 1. Defined correctly within the 'let' scope
      system = "x86_64-linux";
      username = "caramujosan";

      # 2. Adjusted helper function
      mkSystem = hostName: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          
          # Global configuration for free/non-free packages
          {
            nixpkgs.config.allowUnfree = true;
          }

          # Home Manager module integration
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [
              nix-flatpak.homeManagerModules.nix-flatpak
            ];

           # Import the home.nix file for the user
            home-manager.users.${username} = import ./home.nix;
          }
        ];
      };
    in {
      # 3. Correctly maps hosts for nixos-rebuild
      nixosConfigurations = {
        # To run nixos-rebuild --flake .#nixos
        nixos = mkSystem "nixos";
      };
    };
}
