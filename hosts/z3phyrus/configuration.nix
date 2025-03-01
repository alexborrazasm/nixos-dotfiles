# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{ config, pkgs, inputs, nixosModules , ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.hardware.nixosModules.asus-zephyrus-ga402
      nixosModules
    ];

  system.stateVersion = "24.11";

  # Custom modules
  base.enable = true;
  zsh.enable = true;
  asus-utils.enable = true;
  headset-control.enable = true;
  gnome.enable = true;
  fonts-config.enable = true;

  environment.systemPackages = with pkgs; [
    os-prober
    ntfs3g
  ];
  
  boot.loader.systemd-boot.enable = false;  # Diasable systemd-boot
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
    default = "saved";
    extraConfig = ''
      set save_default=true
    '';
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

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "alex" = import ./home.nix;
    };
  };
}