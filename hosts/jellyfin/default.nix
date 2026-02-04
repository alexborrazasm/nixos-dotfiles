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
    ../../modules/nixos/neovim.nix
    ../../modules/nixos/intel-vgpu.nix
  ];
  
  # Enable jellyfin
  services.jellyfin.enable = true;
  networking.firewall.allowedTCPPorts = [ 8096 ];

  # Enable NFS
  services.rpcbind.enable = true; 
  # Jellyfin data
  fileSystems."/media/jellyfin" = {
    device = "10.10.10.1:/tankhdd/media/jellyfin";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" "soft" "timeo=100" ];
  };
  
  # Set hostname
  networking.hostName = "jellyfin";
  
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
