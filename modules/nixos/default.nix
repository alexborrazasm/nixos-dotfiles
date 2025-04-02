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
  ];

  # Default true
  base.enable = mkDefault true;
  zsh.enable = mkDefault true;
  fonts-config.enable = mkDefault true;
  
  # Default false
  asus-utils.enable = mkDefault false;
  headset-control.enable = mkDefault false;
  gnome.enable = mkDefault true;
  wireguard.enable = mkDefault true;
}

