{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.fonts-config;
in {
  options.fonts-config = {
    enable = mkEnableOption "fonts configuration";
  };

  config = mkIf cfg.enable {
    fonts = {
      fontDir.enable = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
        # sans-serif
        noto-fonts
        liberation_ttf
        ubuntu_font_family

        # serif
        dejavu_fonts
        noto-fonts-emoji

        # mono
        fira-code
        jetbrains-mono
        hack-font
        nerd-fonts.cousine
        
        # icons
        font-awesome
      ];

      fontconfig = {
        defaultFonts = {
          serif = [ "DejaVu Serif" "Noto Serif" ];
          sansSerif = [ "Ubuntu" "Noto Sans" ];
          monospace = [ "Cousine Nerd Font Mono" "JetBrains Mono" "Hack" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}

