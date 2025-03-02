{ lib, ... }:

{
  imports = [
    ./base.nix
    ./zsh.nix
    ./asus-utils.nix
    ./headset-control.nix
    ./gnome.nix
    ./fonts-config.nix
    ./nvim.nix
  ];

  # Default true
  base.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  fonts-config.enable = lib.mkDefault true;
  nvim.enable = lib.mkDefault true;
  
  # Default false
  asus-utils.enable = lib.mkDefault false;
  headset-control.enable = lib.mkDefault false;
  gnome.enable = lib.mkDefault true;
}

