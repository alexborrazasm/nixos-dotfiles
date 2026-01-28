{
  pkgs,
  nixpkgs-stable,
  username,
  ...
}: {
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
      package = nixpkgs-stable.legacyPackages.${pkgs.system}.virtualbox;
    };
    guest.enable = true;
    guest.dragAndDrop = true;
  };

  users.extraGroups.vboxusers.members = [ username ];
}
