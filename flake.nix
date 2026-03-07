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
  }: let
    username = "alex";
    system = "x86_64-linux";
    homeModules = [
      ./homes/${username}/home.nix
      stylix.homeModules.stylix
      inputs.eden.homeModules.default
    ];
  in {
    nixosConfigurations = {
      zen = let
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
                imports = homeModules;
              };
            }
          ];
        };
      frontend = let
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

    homeConfigurations = {
      ${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs username; };
        modules = homeModules;
      };
    };
 };

}
