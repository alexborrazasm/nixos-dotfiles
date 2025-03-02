# modules/home-manager/default.nix
{ lib, ... }:

{
  imports = [
    ./git.nix
    ./chrome.nix
  ];

  # Default config
  git.enable = lib.mkDefault false;
  chrome.enable = lib.mkDefault false;
}

