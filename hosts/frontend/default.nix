{
  modulesPath,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix

    # Modules
    ../../modules/nixos/common.nix
    ../../modules/nixos/server-users.nix
    ../../modules/nixos/ssh.nix
    ../../modules/nixos/fail2ban.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/neovim.nix
  ];
  
  # Set hostname
  networking.hostName = "frontend";
  
  # Enable cloud-init service
  services.cloud-init.enable = true;

  # Enable network configuration via cloud-init
  services.cloud-init.network.enable = true;

  # Set systemd-networkd
  networking.useNetworkd = true;

  environment.systemPackages = with pkgs; [
    cloud-utils
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking.firewall = {
    enable = true;
    #allowedTCPPorts = [ 80 443 ];
    #allowedUDPPortRanges = [
    #  { from = 4000; to = 4007; }
    #  { from = 8000; to = 8010; }
    #];
  };

  system.stateVersion = "25.11";
}
