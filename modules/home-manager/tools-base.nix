# modules/home-manager/tools-base.nix
{ config, pkgs, pkgsUnstable, lib, ... }:

with lib;

let 
  cfg = config.tools-base;
in {
  options.tools-base = {
    enable = mkEnableOption "Base tools";
  };
  
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ 
      # Utility
      rlwrap
      zip
      unzip
      xz
      unrar
      tree
      fastfetch
      htop
      btop
      
      # Networking tools
      nmap
      dnsutils
      traceroute
    ];
  };
}