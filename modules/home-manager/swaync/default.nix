{ 
  config,
  pkgs, 
  ... 
}: {
  
  services.swaync = {
    enable = true;
    
    # https://github.com/ErikReider/SwayNotificationCenter/blob/main/src/configSchema.json
    settings = {
      positionX = "right";
      positionY = "top";
      timeout = 3;
      timeout-low = 1;
      timeout-critical = 0;
    };
  };

  home.packages = with pkgs; [
    libnotify # for debug
  ];

}