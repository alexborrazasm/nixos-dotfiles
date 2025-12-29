{ 
  config, 
  pkgs,
  lib,
  ... 
}: {
  imports = 
  [
    ../waybar
    ../kitty
    ../wofi
  ];

  wayland.windowManager.hyprland.enable = true;

  # Avoid conflicts with UWSM
  wayland.windowManager.hyprland.systemd.enable = false;

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  services.hyprpaper.enable = true;

  home.packages = with pkgs; [
    jq # for workspace script
    networkmanagerapplet
    blueman
    brightnessctl
    playerctl
    pavucontrol
    pamixer
  ];

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
    
  home.file.".config/hypr" = {
    source = ./config;
    recursive = true;
    force = true;
  };

}

