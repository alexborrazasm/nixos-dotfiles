# hosts/z3phyrus/hardware-configuration.nix
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8680aea3-be9c-4a85-8eb6-88f1529b1f1e";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2D7A-45EC";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  
  swapDevices =
    [ { device = "/dev/disk/by-uuid/a9813738-be10-4981-b4b9-08c1a4061c4e"; }
    ];

  fileSystems."/mnt/data" =
    { device = "/dev/disk/by-uuid/5C12CE0012CDDEE0";
      fsType = "ntfs";
      options = [ "fmask=0077" "dmask=0077" "uid=1000" "gid=100" ];
    };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
