{ 
  pkgs, 
  ... 
}: {
  stylix = {
    enable = true;

    image = ./wallpapers/nix-black-4k.png;
    #image = ./wallpapers/ocean_with_cloud.png;

    # Use a prebuilt theme from the base16-schemes package
    # See https://github.com/tinted-theming/schemes/tree/spec-0.11/base16
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

    # Use a custom local theme file
    base16Scheme = ./catppuccin-mocha.yaml;
    
    polarity = "dark";

    # Fix for GTK dialogs having unreadable text buttons
    # https://github.com/nix-community/stylix/issues/1560
    targets.gtk.extraCss = ''
      .dialog-action-area > .text-button {
        color: @dialog_fg_color;
      }      
    '';

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        terminal = 15;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    cursor = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "Catppuccin-Mocha-Dark-Cursors";
      size = 24;
    };

  };

}
