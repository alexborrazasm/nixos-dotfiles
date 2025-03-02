# modules/home-manager/default.nix
{ lib, ... }:

{
  imports = [
    ./git.nix
  ];

  # Default config
  git.enable = lib.mkDefault false;
}

