# modules/nixos/base.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.base;
in {
  options.base = {
    enable = mkEnableOption "base configuration";
  };

  config = mkIf cfg.enable {
    # Set your time zone.
    time.timeZone = "Europe/Madrid";

    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };    

    # Select internationalization properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "es_ES.UTF-8/UTF-8"
    ];
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "es_ES.UTF-8";
      LC_IDENTIFICATION = "es_ES.UTF-8";
      LC_MEASUREMENT = "es_ES.UTF-8";
      LC_MONETARY = "es_ES.UTF-8";
      LC_NAME = "es_ES.UTF-8";
      LC_NUMERIC = "es_ES.UTF-8";
      LC_PAPER = "es_ES.UTF-8";
      LC_TELEPHONE = "es_ES.UTF-8";
      LC_TIME = "es_ES.UTF-8";
    };

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable CUPS to print documents
    services.printing.enable = true;

    # Install firefox
    programs.firefox.enable = true;

    # Enable sound with pipewire
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Keyboard layout configuration
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    programs.nix-ld.enable = true;

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
      vim
      curl
      wget
      git
      htop
      fastfetch
      tree
      lm_sensors
      home-manager
      linuxPackages.cpupower
      cpuid
      utillinux
      usbutils
      pciutils
      man-pages 
      man-pages-posix
    ];

    documentation = {
      man = {
        enable = true;
        man-db.enable = true;
        generateCaches = true;
      };
      dev = {
        enable = true;
      };
    };
  };
}
