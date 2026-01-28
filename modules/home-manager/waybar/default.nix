{ 
  config, 
  pkgs, 
  ... 
}: {
  
  programs.waybar = {
    enable = true;
  };

  stylix.targets.waybar.enable = false;

  home.file.".config/waybar/themes/colors.css".text = ''
    /* Stylix theme */

    /* Base colors */
    @define-color base   #${config.lib.stylix.colors.base00};
    @define-color mantle #${config.lib.stylix.colors.base01};

    /* Surface colors */
    @define-color surface0 #${config.lib.stylix.colors.base02};
    @define-color surface1 #${config.lib.stylix.colors.base03};
    
    /* Text colors */
    @define-color text     #${config.lib.stylix.colors.base05};

    /* Accent colors */
    @define-color rosewater #${config.lib.stylix.colors.base06};
    @define-color lavender  #${config.lib.stylix.colors.base07};
    @define-color red       #${config.lib.stylix.colors.base08};
    @define-color peach     #${config.lib.stylix.colors.base09};
    @define-color yellow    #${config.lib.stylix.colors.base0A};
    @define-color green     #${config.lib.stylix.colors.base0B};
    @define-color sapphire  #${config.lib.stylix.colors.base0C};
    @define-color blue      #${config.lib.stylix.colors.base0D};
    @define-color mauve     #${config.lib.stylix.colors.base0E};
    @define-color flamingo  #${config.lib.stylix.colors.base0F};

    /* Additional styling variables - using solid colors instead of rgba */
    @define-color background-primary @base;
    @define-color border-color       @surface1;
    
    /* Status colors */
    @define-color success @green;
    @define-color warning @yellow;
    @define-color error   @red;
    @define-color info    @blue;

  '';

  home.file.".config/waybar" = {
    source = ./config;
    recursive = true;
    force = true;
  };

}
