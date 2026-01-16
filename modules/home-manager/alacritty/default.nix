{
  config,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
  
    settings = {
      window.padding = {
        x = 8;
      };
      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
        unfocused_hollow = true;
      };
    };
  };
}
