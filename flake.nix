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
      
      pkgsConfig = {
        allowUnfree = true;
      };
      
      pkgs = import nixpkgs {
        inherit system;
        config = pkgsConfig;
      };
      
      pkgsUnstable = import nixpkgsUnstable {
        inherit system;
        config = pkgsConfig;
      };
    in
    {
      nixosConfigurations = {
        z3phyrus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgsUnstable;
          };
          modules = [
            ./hosts/z3phyrus
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
          inherit pkgs;
          extraSpecialArgs = {
            inherit pkgs pkgsUnstable;
          };
          modules = [ 
            ./homes/alex-z3phyrus
            ./modules/home-manager
            {
              git.enable = true;
              chrome.enable = true;
              zsh.enable = true;
              nvim.enable = true;
            }
          ];
        };
        "wsl" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit pkgs pkgsUnstable;
          };
          modules = [ 
            ./homes/alex-wsl
            ./modules/home-manager
            {
              git.enable = true;
              zsh.enable = true;
              nvim.enable = true;
            }
          ];
        };
      };
    };
}