{ 
  config,
  pkgs, 
  username,
  ... 
}: {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  nixpkgs.config.allowUnfree = true;

  xdg.userDirs.enable = true;

}

