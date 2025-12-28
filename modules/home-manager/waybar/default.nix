{ 
  config, 
  pkgs, 
  ... 
}: {

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  home.file.".config/waybar" = {
    source = ./config;
    recursive = true;
    force = true;
  };

}
