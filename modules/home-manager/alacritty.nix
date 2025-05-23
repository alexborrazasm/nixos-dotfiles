# modules/home-manager/alacritty.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.alacritty;
in {
  options.alacritty = {
    enable = mkEnableOption "Alacritty configuration";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      
      settings = {
        window = {
          opacity = 1.0;
          padding = {
            x = 0;
            y = 10;
          };
          dimensions = {
            columns = 80;
            lines = 20;
          };
        };
        
        font = {
          normal = {
            family = "Cousine Nerd Font";
          };
          size = 15;
        };
        
        cursor = {
          style = "Beam";
        };
        
        # Tu tema personalizado
        colors = {
          primary = {
            background = "#000000";
            foreground = "#ffffff";
          };
          
          normal = {
            black = "#000000";
            red = "#c01c28";
            green = "#26a269";
            yellow = "#a2734c";
            blue = "#12488b";
            magenta = "#a347ba";
            cyan = "#2aa1b3";
            white = "#d0cfcc";
          };
          
          bright = {
            black = "#5e5c64";
            red = "#f66151";
            green = "#33d17a";
            yellow = "#e9ad0c";
            blue = "#2a7bde";
            magenta = "#c061cb";
            cyan = "#33c7de";
            white = "#ffffff";
          };
        };
      };
    };

    home.sessionVariables = {
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE = "24";      
      GDK_BACKEND = "wayland";  
    };

    home.packages = with pkgs; [
      alacritty
    ];
  };
}
