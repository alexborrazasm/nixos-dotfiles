{ 
  config, 
  pkgs, 
  ... 
}: {

  stylix.targets.firefox.enable = false;

  programs.firefox = {
    enable = true;
  };

}
