{
  description = "Alexborrazasm's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgsUnstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgsUnstable = nixpkgsUnstable.legacyPackages.${system};  
      
      # Import all modules from modules.nix
      nixosModules.default = import ./modules/nixos/modules.nix;
    in
    {
      # Expose the modules
      inherit nixosModules;
      
      nixosConfigurations = {
        z3phyrus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgsUnstable;
            inherit (self) nixosModules;
          };
          modules = [
            ./hosts/z3phyrus/configuration.nix
          ];
        };
      };
    };
}