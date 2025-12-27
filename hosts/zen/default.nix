{ 
  config, 
  pkgs, 
  ... 
}: {
  imports =
    [
      ../../modules/nixos/common.nix
      ../../modules/nixos/hypr.nix
      ../../modules/nixos/fonts.nix

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
 
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = false;  # Disable systemd-boot
      efi.canTouchEfiVariables = true;
      
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
        default = "saved";
        extraConfig = ''
          set save_default=true
        '';
      };
    };

    plymouth.enable = true;

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelPackages = pkgs.linuxPackages_zen; # use zen kernel
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  networking.hostName = "zen"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
