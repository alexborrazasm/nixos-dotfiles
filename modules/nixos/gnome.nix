{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.gnome;
in {
  options.gnome = {
    enable = mkEnableOption "GNOME configuration";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.mutter ];
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['scale-monitor-framebuffer']
          [org.gnome.desktop.interface]
          icon-theme='Papirus'
        '';
      };
    };

    # Install GNOME applications and extensions
    environment.systemPackages = with pkgs; [
      # GNOME apps
      gnome-tweaks
      papirus-icon-theme 
      
      # GNOME extensions
      gnomeExtensions.blur-my-shell
      gnomeExtensions.color-picker
      gnomeExtensions.headsetcontrol
      gnomeExtensions.dash-to-dock
      gnomeExtensions.clipboard-history
      gnomeExtensions.gpu-supergfxctl-switch
      gnomeExtensions.ip-indicator
    ];
  };
}

