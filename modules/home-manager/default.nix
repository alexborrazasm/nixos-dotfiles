# modules/home-manager/default.nix
{ lib, ... }:

{
  imports = [
    ./git.nix
    ./chrome.nix
    ./zsh.nix
    ./nvim.nix
  ];

  # Default config
  git.enable = lib.mkDefault false;
  chrome.enable = lib.mkDefault false;
  zsh.enable = lib.mkDefault false;
  nvim.enable = lib.mkDefault false;
}

