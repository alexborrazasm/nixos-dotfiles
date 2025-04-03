# hosts/z3phyrus/default.nix
{ config, pkgs, inputs, nixosModules , ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.hardware.nixosModules.asus-zephyrus-ga402
    ];

  system.stateVersion = "24.11";

  environment.systemPackages = with pkgs; [
    os-prober
    ntfs3g
    linuxPackages.cpupower
    cpuid
    pkgs.linuxPackages_latest.perf
  ];
  
  powerManagement.cpufreq.max = 3200000; 

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
        theme = "/home/alex/nix-config/hosts/z3phyrus/grub/themes/min_rog";
        gfxmodeEfi = "2560x1440,auto";
        splashImage = "/home/alex/nix-config/hosts/z3phyrus/grub/themes/min_rog/background.png";
        extraConfig = ''
          set save_default=true
        '';
      };
    };

    plymouth.enable = true;

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "ipv6.disable=1"
    ];
  };
  
  networking.hostName = "z3phyrus";

  # X11 keymap configuration
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account
  users.users.alex = {
    isNormalUser = true;
    description = "alex";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Set root's shell to zsh
  users.users.root.shell = pkgs.zsh;
}
