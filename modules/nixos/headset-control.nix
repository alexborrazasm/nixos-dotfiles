# modules/nixos/headset-control.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.headset-control;
in {
  options.headset-control = {
    enable = mkEnableOption "HeadsetControl configuration";
  };

  config = mkIf cfg.enable {
    # Install HeadsetControl
    environment.systemPackages = with pkgs; [
      headsetcontrol
    ];

    # Add udev rules for HeadsetControl
    services.udev.packages = [ pkgs.headsetcontrol ];
  };
}

