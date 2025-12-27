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

  # Avoid conflicts with uwsm
  wayland.windowManager.hyprland.systemd.enable = false;

  home.packages = with pkgs; [
    jq # for workspace script
  ];
    
  home.file.".config/hypr" = {
    source = ./dotfiles;
    recursive = true;
    force = true;
  };

}

