# modules/nixos/wireguard.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.wireguard;
in {
  options.wireguard = {
    enable = mkEnableOption "Wireguard configuration";
  };
  
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wireguard-tools
    ];
    
    systemd.services."wg-quick-wg0" = {
      serviceConfig = { Restart = "on-failure"; RestartSec = "10s"; };
      unitConfig.StartLimitIntervalSec = 0;
    };

    networking.wg-quick.interfaces.wg0 = {
      autostart = true;
      configFile = "/etc/wireguard/wg0.conf";
    };

    networking.nameservers = [
      "192.168.9.150"  # DNS HOME 
      "1.1.1.1"        # DNS Google
      "8.8.8.8"        # DNS Cloudflare
    ];
  };
}
