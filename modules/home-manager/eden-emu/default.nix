{ 
  config, 
  pkgs, 
  ... 
}: {
  
  programs.eden = {
    enable = true;
    enableCache = true;
  };

}
