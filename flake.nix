{
  description = "NixOS configuration of Alexborrazasm";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    stylix,
    ...
  }: {
    nixosConfigurations = {
      zen = let
        username = "alex";
        specialArgs = { inherit username; };
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;

          modules = [
            ./hosts/zen
            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = {
                imports = [
                  ./homes/${username}/home.nix
                   stylix.homeModules.stylix
                ];
              };
            }
          ];
        };
    };
    
    homeConfigurations = {
      wsl = let
        username = "alex";
        system = "x86_64-linux";
        specialArgs = { inherit username; };
      in
        home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        extraSpecialArgs = inputs // specialArgs;

        modules = [
          ./homes/${username}-wsl/home.nix
          stylix.homeModules.stylix
        ];
      };
    };
  };

}
