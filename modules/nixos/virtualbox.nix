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

  # EII lab
  environment.systemPackages = [
    pkgs.vagrant
    (pkgs.makeDesktopItem {
      name = "virtualbox";
      desktopName = "Oracle VM VirtualBox";
      exec = "env XDG_CURRENT_DESKTOP=GNOME VirtualBox %U";
      icon = "virtualbox";
      categories = [ "System" "Emulator" ];
      terminal = false;
    })
  ];

}
