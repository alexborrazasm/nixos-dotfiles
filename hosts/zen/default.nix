{ 
  config, 
  pkgs, 
  username,
  ... 
}: 

{
  imports = [
    ../../modules/nixos/common.nix
    ../../modules/nixos/hypr.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/solaar.nix # Logitech G733 control
    ../../modules/nixos/docker-rootless.nix
    ../../modules/nixos/embedded_dev.nix
    ../../modules/nixos/printer.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/virtualbox.nix
    ../../modules/nixos/neovim.nix
    ../../modules/nixos/tuigreet-autounlock.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
 
  # Bootloader
  boot = {
    initrd.systemd.enable = true;

    loader = {
      systemd-boot.enable = false;  # Disable systemd-boot
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
        gfxmodeEfi = "2880x1800,auto";
        splashImage = null;
        default = "saved";
        extraConfig = ''
          set save_default=true
        '';
        theme = pkgs.stdenv.mkDerivation {
          pname = "distro-grub-themes";
          version = "3.1";
          src = pkgs.fetchFromGitHub {
            owner = "AdisonCavani";
            repo = "distro-grub-themes";
            rev = "v3.1";
            hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
          };
          installPhase = "cp -r customize/nixos $out";
        };
      };
    };

    plymouth.enable = true;

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    #kernelPackages = pkgs.linuxPackages_zen; # use zen kernel
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "kvm.enable_virt_at_load=0"
    ];
  };
  
  programs.zsh.enable = true;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  networking.hostName = "zen";

  hardware.bluetooth.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Filesystem settings for Btrfs
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
  };

  services.btrfs.autoScrub.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # NixOS will automatically create the swap file with the appropriate 
  # attributes for Btrfs including disabling copy on write.
  swapDevices = [{ 
    device = "/swap/swapfile"; 
    size = 8*1024; # Creates an 8GB swap file 
  }];

  # Firewall is enabled by default in NixOS, but to ensure it's active
  networking.firewall = {
    enable = true;
    # Example to open ports:
    #allowedTCPPorts = [ 80 443 ];
    #allowedUDPPortRanges = [
    #  { from = 4000; to = 4007; }
    #  { from = 8000; to = 8010; }
    #];
  };

  # Enable the dynamic library loader for unpatched binaries
  programs.nix-ld.enable = true;
  
  # To manage screen brightness without sudo
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
