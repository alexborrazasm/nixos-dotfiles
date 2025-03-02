{
  description = "Alexborrazasm's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgsUnstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgsUnstable = nixpkgsUnstable.legacyPackages.${system};  
    in
    {
      nixosConfigurations = {
        z3phyrus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgsUnstable;
          };
          modules = [
            ./hosts/z3phyrus/configuration.nix
            ./modules/nixos 
            { 
              # Enable optional modules
              gnome.enable = true;
              asus-utils.enable = true;
              headset-control.enable = true;
            }
          ];
        };
      };

      homeConfigurations = {
        "alex@z3phyrus" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit inputs pkgs pkgsUnstable;
          };
          modules = [ 
            ./homes/alex-z3phyrus/home.nix
            ./modules/home-manager
            {

            }
          ];
        };
      };
    };
}