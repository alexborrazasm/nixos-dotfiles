# modules/nix-os/wireguard.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.wireguard;
in {
  options.wireguard = {
    enable = mkEnableOption "Alacritty configuration";
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
  };
}
