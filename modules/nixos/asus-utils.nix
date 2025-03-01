{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.asus-utils;
in {
  options.asus-utils = {
    enable = mkEnableOption "ASUS utilities";
  };

  config = mkIf cfg.enable {
    # Enable and configure Supergfxctl
    services.supergfxd = {
      enable = true;
    };

    # Enable and configure Asusctl
    services.asusd = {
      enable = true;
      enableUserService = true;
    };

    # Install the necessary packages
    environment.systemPackages = with pkgs; [
      supergfxctl
      asusctl
    ];
  };
}
