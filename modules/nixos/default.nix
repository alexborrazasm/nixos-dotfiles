# modules/nixos/default.nix
{ lib, ... }:

with lib;

{
  imports = [
    ./base.nix
    ./zsh.nix
    ./asus-utils.nix
    ./headset-control.nix
    ./gnome.nix
    ./fonts-config.nix
    ./wireguard.nix
    ./platformio-udev.nix
  ];

  # Default true
  base.enable = mkDefault true;
  zsh.enable = mkDefault true;
  fonts-config.enable = mkDefault true;
  
  # Default false
  asus-utils.enable = mkDefault false;
  headset-control.enable = mkDefault false;
  gnome.enable = mkDefault false;
  wireguard.enable = mkDefault true;
  platformio-udev.enable = mkDefault false;
  
}

