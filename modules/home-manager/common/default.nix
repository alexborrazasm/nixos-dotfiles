{ 
  config,
  pkgs, 
  username,
  ... 
}: {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    tree
  ];

  xdg.userDirs.enable = true;

}

