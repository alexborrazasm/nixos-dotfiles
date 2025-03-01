{ lib, ... }:

{
  imports = [
    ./base.nix
    ./zsh.nix
    ./asus-utils.nix
    ./headset-control.nix
    ./gnome.nix
    ./fonts-config.nix
  ];

  # Default config
  base.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault false;
  fonts-config.enable = lib.mkDefault false;
  asus-utils.enable = lib.mkDefault false;
  headset-control.enable = lib.mkDefault false;
  gnome.enable = lib.mkDefault false;
}

