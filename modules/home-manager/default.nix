# modules/home-manager/default.nix
{ lib, ... }:

with lib;

{
  imports = [
    ./git.nix
    ./chrome.nix
    ./zsh.nix
    ./nvim.nix
    ./alacritty.nix
  ];

  # Default config
  git.enable = mkDefault false;
  chrome.enable = mkDefault false;
  zsh.enable = mkDefault false;
  nvim.enable = mkDefault false;
  alacritty.enable = mkDefault false;
}

