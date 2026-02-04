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
    ../../modules/nixos/intel-vgpu.nix
  ];
  
  # Set hostname
  networking.hostName = "iot";
  
  services.qemuGuest.enable = true;
  
  # Enable cloud-init service
  services.cloud-init.enable = true;

  # Enable network configuration via cloud-init
  services.cloud-init.network.enable = true;

  # Set systemd-networkd
  networking.useNetworkd = true;

  environment.systemPackages = with pkgs; [
    cloud-utils
  ];
  
  # Enable NFS
  services.rpcbind.enable = true; 
  # Frigate data data
  fileSystems."/media/frigate" = {
    device = "10.10.10.1:/tank1tb/frigate";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" "timeo=100" ];
  };
  
  swapDevices = [
    {
      device = "/swapfile";
      size = 1024;
    }
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
