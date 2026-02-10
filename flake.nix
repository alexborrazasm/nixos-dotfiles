{
  description = "NixOS configuration of Alexborrazasm";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprdynamicmonitors.url = "github:fiffeek/hyprdynamicmonitors";
    sunsetr.url = "github:psi4j/sunsetr";
    eden.url = "github:grantimatter/eden-flake";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    intel-sriov = {
      url = "github:strongtz/i915-sriov-dkms";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    stylix,
    hyprdynamicmonitors,
    sunsetr,
    disko,
    intel-sriov,
    ...
  }: {
    nixosConfigurations = {
      zen = let
        username = "alex";
        session = "start-hyprland > /dev/null";
        specialArgs = { inherit username session nixpkgs-stable; };
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;

          modules = [
            ./hosts/zen
            home-manager.nixosModules.home-manager

            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = {
                inherit inputs username;
              };

              home-manager.users.${username} = {
                imports = [
                  ./homes/${username}/home.nix
                  stylix.homeModules.stylix
                  inputs.eden.homeModules.default
                ];
              };
            }
          ];
        };
      frontend = let
        username = "alex";
        specialArgs = { inherit username nixpkgs-stable; };
      in
        nixpkgs-stable.lib.nixosSystem {
          inherit specialArgs;

          modules = [
            disko.nixosModules.disko
            ./hosts/frontend
          ];
        };
      jellyfin = let
        username = "alex";
        specialArgs = { inherit username nixpkgs-stable; };
      in
        nixpkgs-stable.lib.nixosSystem {
          inherit specialArgs;

          modules = [
            disko.nixosModules.disko
            intel-sriov.nixosModules.default
            ./hosts/jellyfin
          ];
        };

      iot = let
        username = "alex";
        specialArgs = { inherit username nixpkgs-stable; };
      in
        nixpkgs-stable.lib.nixosSystem {
          inherit specialArgs;

          modules = [
            disko.nixosModules.disko
            intel-sriov.nixosModules.default
            ./hosts/iot
          ];
        };
    };
    
#    homeConfigurations = {
#      wsl = let
#        username = "alex";
#        system = "x86_64-linux";
#        specialArgs = { inherit username; };
#      in
#        home-manager.lib.homeManagerConfiguration {
#        pkgs = nixpkgs.legacyPackages.${system};
#
#        extraSpecialArgs = inputs // specialArgs;
#
#        modules = [
#          ./homes/${username}-wsl/home.nix
#          stylix.homeModules.stylix
#        ];
#      };
#    };
 };

}
